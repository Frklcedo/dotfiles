local wibox = require("wibox")
local beautiful = require("beautiful")

local base = {}
function base:shellcmd(cmd)
    return { "/bin/sh", "-c", cmd }
end
function base:primary_bg(widget)
    local wrapper = wibox.container.background(widget, beautiful.colors.primary)
    wrapper:set_fg(beautiful.colors.dark)
    return wrapper
end
function base:secondary_bg(widget)
    local wrapper = wibox.container.background(widget, beautiful.colors.secondary)
    wrapper:set_fg(beautiful.colors.white)
    return wrapper
end

return base
