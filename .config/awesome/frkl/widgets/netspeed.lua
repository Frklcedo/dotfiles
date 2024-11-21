local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local netspeed = require("frkl.utils.netspeed")

widget = {}

widget.unavailable_icon = " 󱞐  "
widget.wifi_icon = " 󰤨 "

widget.textbox = wibox.widget.textbox(widget.unavailable_icon)
widget.widget = wibox.container.background(widget.textbox, beautiful.colors.secondary)
widget.widget:set_fg(beautiful.colors.white)

gears.timer {
    timeout   = 1,
    call_now  = true,
    autostart = true,
    callback  = function()
        local speed = netspeed:get_netspeed()
        if not speed then
            widget.textbox:set_text(widget.unavailable_icon)
        end
        if speed < 1024 then
            widget.widget:set_bg(beautiful.colors.danger)
            widget.textbox:set_text(string.format("  %iB/s %s ", speed, widget.wifi_icon))
        else
            widget.widget:set_bg(beautiful.colors.secondary)
            widget.textbox:set_text(string.format("  %.1fKB/s %s ", speed / 1024, widget.wifi_icon))
        end
    end
}

return widget
