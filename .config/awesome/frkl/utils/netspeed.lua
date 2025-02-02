local netspeed = {}

netspeed.netpath = '/sys/class/net'
netspeed.interfaces = {}

function netspeed:get_interfaces()
    local ip = io.popen("ip -br address show | awk '{print $1}'", "r")
    if not ip then
        return
    end
    local interface_groups = { {}, {} }
    while true do
        local line = ip:read()
        if line == nil then break end
        if line:match("^e") then
            table.insert(interface_groups[1], line)
        elseif line:match("^w") then
            table.insert(interface_groups[2], line)
        end
    end
    ip:close()
    return interface_groups
end
function netspeed:setup_interfaces(interface_groups)
    for _, interfaces in ipairs(interface_groups) do
        for _, interface in ipairs(interfaces) do
            table.insert(self.interfaces, interface)
        end
    end
end
function netspeed:read_netfile(filepath, readmode)
    if readmode == nil then
        readmode = "*l"
    end
    local f = io.open(filepath, "r")
    if not f then
        return false
    end
    local line = f:read(readmode)
    f:close()
    return line
end
function netspeed:get_netstatus(interface)
    return self:read_netfile(string.format('%s/%s/operstate', self.netpath, interface))
end

function netspeed:get_rx_bytes(interface)
    local rx_bytes = self:read_netfile(
        string.format('%s/%s/statistics/rx_bytes', self.netpath, interface),
        "*number"
    )
    if type(rx_bytes) == 'number' then
        return rx_bytes
    end
    return 0
end
function netspeed:get_speed(interface)
    local rx_bytes = self:get_rx_bytes(interface)

    local tmp_path = string.format("/tmp/%s_rx", interface)

    local tmp_file = io.open(tmp_path, "r+")
    if not tmp_file then
        tmp_file = io.open(tmp_path, "w")
        if tmp_file then
            tmp_file:write(rx_bytes)
            tmp_file:close()
        end
        return 0
    end

    local tmp_bytes = tmp_file:read("*number")
    if not tmp_bytes then
        tmp_bytes = rx_bytes
    end
    tmp_file:seek("set", 0)
    tmp_file:write(rx_bytes)
    tmp_file:close()
    return rx_bytes - tmp_bytes
end

function netspeed:get_interface_speed(index)
    local interface = self.interfaces[index]
    if not interface then
        return false
    end
    local status = self:get_netstatus(interface)
    if status ~= 'up' then
        return self:get_interface_speed(index + 1)
    end
    return self:get_speed(interface)
end

function netspeed:get_netspeed()
    self:setup_interfaces(self:get_interfaces())

    if #self.interfaces > 0 then
        local speed = netspeed:get_interface_speed(1)
        return speed
    end

    return ''
end

function netspeed:netspeed()
    print(self:get_netspeed())
end

--[[ if arg[1] == 'loop' then
    local count = 1
    while count < 10 do
        netspeed:netspeed()
        os.execute("sleep " .. 2)
        count = count + 1
    end
end ]]

return netspeed
