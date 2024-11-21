local netspeed = {}

netspeed.netpath = '/sys/class/net'
netspeed.interfaces = { {}, {}}

function netspeed:get_netstatus(interface)
    return self:read_netfile(string.format('%s/%s/operstate', self.netpath, interface))
end

function netspeed:get_interfaces()
    local ip = io.popen("ip -br address show | awk '{print $1}'", "r")
    if not ip then
        return
    end
    while true do
        local line = ip:read()
        if line == nil then break end
        if line:match("^e") then
            table.insert(self.interfaces[1], line)
        elseif line:match("^w") then
            table.insert(self.interfaces[2], line)
        end

    end
    ip:close()
end

function netspeed:read_netfile(filepath, readmode)
    if readmode == nil then
        readmode = "l"
    end
    local f = io.open(filepath, "r")
    if not f then
        return false
    end
    local line = f:read(readmode)
    f:close()
    return line
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

function netspeed:up_interfaces(interfaces)
    if not (#interfaces > 0) then
        return false
    end
    for _, interface in pairs(interfaces) do
        local operstate = self:get_netstatus(interface)
        if operstate == 'up'  then
            return self:get_speed(interface)
        end
    end
    return false
end

function netspeed:get_netspeed()
    self:get_interfaces()
    for _, interfaces in ipairs(self.interfaces) do
        local netspeed = self:up_interfaces(interfaces)
        if netspeed then
            return netspeed
        end
    end

    return ''
end

function netspeed:netspeed()
    print(self:get_netspeed())
end

return netspeed
