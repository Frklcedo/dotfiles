-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
local altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual",      terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart",     awesome.restart },
    { "quit",        function() awesome.quit() end },
}

local menuapplications = {
    { "Brave", "brave" },
    { "Libreoffice", "libreoffice" },
    { "AudioMix", "qpwgraph"},
    { "Calc", "qalculate-gtk"}
}

mymainmenu = awful.menu({
    items = {
        { "awesome",       myawesomemenu, beautiful.awesome_icon },
        { "applications", menuapplications },
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar



-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

local function map(tb, cb)
    local new_tb = {}
    for i, v in ipairs(tb) do
        new_tb[i] = cb(v)
    end
    return new_tb
end

-- local thinspace = utf8.char(2009)

local my_tags = {
    { key = "w", name = "www",       icon = "󰇧" },
    { key = "e", name = "env",       icon = "󰞷" },
    { key = "r", name = "rec",       icon = "󰛐" },
    { key = "t", name = "task",      icon = "" },
    { key = "s", name = "shell",     icon = "" },
    { key = "d", name = "dev",       icon = "󰗀" },
    { key = "f", name = "free",      icon = "" },
    { key = "g", name = "gaming",    icon = "󰖺" },
    { key = "v", name = "virt",      icon = "" }
}

-- my widgets
-- Create a textclock widget

local base = require("frkl.utils.base")
my_netspeed = require("frkl.widgets.netspeed")
my_netspeed = my_netspeed:create()

my_text_clock = wibox.widget.textclock("  󱑌  %d/%m/%Y %R  ")
my_mem_usage = awful.widget.watch( base:shellcmd("free -h"), 1,
    function (widget, stdout)
        for line in stdout:gmatch("[^\r\n]+") do
            if line:match("^Mem.:") then
                local meminfo = {}
                for info in line:gmatch("%S+") do
                    table.insert(meminfo, info)
                end
                widget:set_text( string.format("    m. %s     %s  ", meminfo[3], meminfo[2]) )
                return
            end
        end
    end
)

-- nvidia-smi --format=csv,noheader,nounits --query-gpu=memory.used,memory.total,utilization.memory,utilization.gpu
my_nvidia_usage = awful.widget.watch("nvidia-smi --format=csv,noheader,nounits --query-gpu=utilization.memory,utilization.gpu", 5, function (widget, stdout)
    local text = {}
    for val in stdout:gmatch("[^,]+") do
        table.insert(text, val:match("^%s*(.-)%s*$"))
    end
    -- widget:set_text(string.format(" 󰾲   %s | %s  ", text[1].."%", text[2].."%" ))
    widget:set_text(string.format(" 󰾲   %s | %s  ", text[1].."%", text[2].."%" ))
end)


my_power_supply = awful.widget.watch("cat /sys/class/power_supply/BAT0/status /sys/class/power_supply/BAT0/energy_now /sys/class/power_supply/BAT0/energy_full", 1, function (widget, stdout)
    local status, energy_now, energy_full = stdout:match("([^\n]+)\n([^\n]+)\n([^\n]+)")
    energy_now = tonumber(energy_now) or 0
    energy_full = tonumber(energy_full) or 0
    local percentage = math.floor( ( energy_now / energy_full ) * 100 )
    if status == 'Full' then
        status = " 󰁹 "
    elseif  percentage < 20 then
        status = status == "Discharging" and " 󰁺 " or ' 󰢟 '
    elseif  percentage < 40 then
        status = status == "Discharging" and " 󰁽 " or ' 󰂇 '
    elseif  percentage < 60 then
        status = status == "Discharging" and " 󰁾 " or ' 󰂉 '
    elseif  percentage < 80 then
        status = status == "Discharging" and " 󰂀 " or ' 󰂊 '
    else
        status = status == "Discharging" and " 󰂂 " or ' 󰂋 '
    end
    widget:set_text(string.format("  %s %i%% ", status, percentage ))
end)


awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(map(my_tags, function(tag)
        return string.format(' %s ', tag.icon)
        -- return string.format("%s   %s", tag.icon, tag.name)
    end), s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.botwibox = awful.wibar({ position = "bottom", screen = s, visible = false })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        {
            layout = wibox.layout.flex.horizontal,
        }, -- Middle widget
        -- wibox.container.place(, "center"),
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            base:secondary_bg(my_nvidia_usage),
            base:primary_bg(my_mem_usage),
            my_netspeed,
            my_power_supply,
            my_text_clock,
            s.mylayoutbox
        },
    }

    s.botwibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
        },
        -- s.mypromptbox,
        s.mytasklist, -- Middle widget
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mykeyboardlayout,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end)
    -- awful.button({}, 4, awful.tag.viewnext),
    -- awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(

-- help
    awful.key({ modkey, }, "q", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),

    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),

    -- toggle
    awful.key({ modkey, }, "Tab", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    -- Layout manipulation

    -- navigation
    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),


    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),


    -- size
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),


    -- screens
    awful.key({ modkey, }, ",", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, }, ".", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),


    -- master size
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),

    -- column number
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),


    -- layouts cycle
    awful.key({ modkey, "Control" }, "k", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Control" }, "j", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control", altkey, }, "space", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),


    --[[ awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),

    awful.key({ modkey, }, "w", function() mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }), ]]



    -- Standard program
    awful.key({ modkey, }, "\\", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "p", function() awful.spawn("dmenu_run") end,
        { description = "dmenu", group = "launcher" }),
    awful.key({ modkey, altkey }, "f", function() awful.spawn("firefox") end,
        { description = "Firefox", group = "launcher" }),
    awful.key({ modkey, altkey }, "b", function() awful.spawn("brave-browser") end,
        { description = "Brave Browser", group = "launcher" }),
    awful.key({ modkey, altkey }, "v", function() awful.spawn("pavucontrol -t 3") end,
        { description = "Audio Control", group = "launcher" }),
    awful.key({ modkey, altkey }, "d", function() awful.spawn("nemo") end,
        { description = "File explorer (nemo)", group = "launcher" }),

    awful.key({}, "Print", function() awful.spawn("flameshot screen -c") end,
        { description = "Print screen", group = "launcher" }),
    awful.key({ modkey, }, "Print", function() awful.spawn("flameshot gui") end,
        { description = "Print GUI", group = "launcher" }),


    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" }),

    --[[ -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    awful.key({ modkey }, "x",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
        { description = "show the menubar", group = "launcher" }), ]]

    awful.key({ modkey, "Control" }, "b", function()
        for s in screen do
            s.botwibox.visible = not s.botwibox.visible
        end
    end, { description = "toggle bottom wibar", group = "awesome" }),
    awful.key({ modkey, }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
        end
    end, { description = "toggle default wibar", group = "awesome" })

)

clientkeys = gears.table.join(

    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
        { description = "close", group = "client" }),

    awful.key({ modkey, }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),

    awful.key({ modkey, "Control" }, "Return",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey, "Shift" }, "Return", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey, }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),

    awful.key({ modkey, "Shift" }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),

    awful.key({ modkey, }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),


    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" })

    --[[ awful.key({ modkey, "Control" }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" }) ]]
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i, mt in pairs(my_tags) do
    -- for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, mt.key,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. mt.key, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, mt.key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. mt.key, group = "tag" }),
        -- Move client and view tag.
        awful.key({ modkey, altkey, "Shift" }, mt.key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "move focused client and view tag #" .. mt.key, group = "tag" }),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, mt.key,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. mt.key, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, mt.key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. mt.key, group = "tag" })
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",   -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "qalculate-gtk",
                "Qalculate-gtk"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = { type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        {     -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- autostart

awful.spawn.with_shell("nitrogen --restore &")
awful.spawn.with_shell("picom --config $HOME/.config/picom/picom.conf &")
--[[ awful.spawn.with_shell("dunst &") ]]
awful.spawn.with_shell("/usr/bin/lxpolkit &")
awful.spawn.with_shell("nm-applet &")
awful.spawn.with_shell("setxkbmap -model abnt2 -layout br")
awful.spawn.with_shell("playerctld daemon")
awful.spawn.with_shell("caffeine &")
