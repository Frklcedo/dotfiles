local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local base = require("frkl.utils.base")
local netspeed = require("frkl.utils.netspeed")

local widget = {}

widget.unavailable_icon = " 󱞐  "
widget.wifi_icon = " 󰤨 "

widget.sec = 2

function widget:update_widget()
    local speed = netspeed:get_netspeed()
    if not speed then
        self.textbox:set_text(self.unavailable_icon)
    end
    speed = speed / self.sec
    if speed < 1024 then
        self.widget:set_bg(beautiful.colors.danger)
        self.textbox:set_text(string.format("  %iB/s %s ", speed, self.wifi_icon))
    elseif speed < 1024 * 1024 then
        self.widget:set_bg(beautiful.colors.secondary)
        self.textbox:set_text(string.format("  %.0fKB/s %s ", speed / 1024, self.wifi_icon))
    else
        self.widget:set_bg(beautiful.colors.secondary)
        self.textbox:set_text(string.format("  %.0fMB/s %s ", speed / ( 1024 * 1024 ), self.wifi_icon))
    end
end

function widget:create()
    self.textbox = wibox.widget.textbox(self.unavailable_icon)
    self.widget = base:secondary_bg(self.textbox)


    self.timer = gears.timer {
        timeout   = widget.sec,
        call_now  = true,
        autostart = true,
        callback  = function()
            local co = coroutine.create(function ()
                self:update_widget()
            end)
            if coroutine.status(co) ~= 'dead' then
                coroutine.resume(co)
            end
        end
    }

    return self.widget
end

return widget
