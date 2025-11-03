# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

##
# python-pip: psutils netifaces
# dependencies:
#       psutils python-dbus-next python-netifaces python-psutil
#       xterm alacritty firefox nitrogen picom
#       nerd-fonts
#       ttf-nerd-fonts-symbols
#       nemo flameshot playerctl
#       alsa-utils(amixer) pwvucontrol rofi
#       emacs pcmanfm
#
# https://aur.archlinux.org/yay-git.git
# yay: brave-bin
# git clone https://git.suckless.org/dmenu

import os
import subprocess
import netifaces
import psutil
import socket

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


@lazy.function
def window_to_prev_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    if qtile.current_window is not None and i != 0:
        qtile.current_window.togroup(qtile.groups[i - 1].name)
        qtile.current_screen.toggle_group(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    if qtile.current_window is not None and i != 6:
        qtile.current_window.togroup(qtile.groups[i + 1].name)
        qtile.current_screen.toggle_group(qtile.groups[i + 1].name)


@lazy.function
def focus_expand_next(qtile):
    qtile.current_layout.next()
    qtile.current_layout.cmd_maximize()


@lazy.function
def focus_expand_prev(qtile):
    qtile.current_layout.prev()
    qtile.current_layout.cmd_maximize()


mod = "mod4"
# terminal = guess_terminal()
# terminal = "xfce4-terminal"
# terminal = "st"
terminal = "alacritty"

startupfile = '/.config/qtile/autostart.sh'
defaultcolor = {
    # "primary": "#FF99BE",
    "primary": "#FF90BE",
    "secondary": "#6B6EBF",
    "black": "#282c34",
    "black_bright": "#5c6370"
}

# no hash
bg_color = defaultcolor['black'].replace('#', '')
# bg_color = "1e2127"
# bg_color = "181A1F"

fontdefault = "sans"
fontdefault = "Ubuntu Nerd Font, Symbols Nerd Font Mono"
fontsize = 12
fontemoji = "Symbols Nerd Font Mono"

pclayout = {
    "margin": 12,
    "border_width": 2,
    "border_focus": defaultcolor['primary'],
    "border_normal": defaultcolor['secondary'],
    "min_ratio": 0.15,
    "max_ratio": 0.85,
}
# collayout = {
#     "margin": 6,
#     "border_on_single": True,
#     "border_focus_stack": defaultcolor['primary'],
#     "border_normal_stack": defaultcolor['secondary'],
#     "insert_position": 1,
# }
# collayout.update(pclayout)


def get_up_if():
    return "wlp0s20f0u3"
    ifs = netifaces.interfaces()
    for iff in ifs:
        if iff != 'lo':
            interface_addrs = psutil.net_if_addrs().get(iff) or []
            if socket.AF_INET in [snicaddr.family for snicaddr in interface_addrs]:
                return iff
    return "wlp0s20f0u3"


keys = [

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),

    Key([mod, "control"], "h", lazy.layout.shrink_main(), desc="back sizing"),
    Key([mod, "control"], "l", lazy.layout.grow_main(), desc="over sizing"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "m", lazy.layout.maximize(), desc="Maximize window"),
    # Key([mod, "mod1"], "m", lazy.layout.toggle_maximize(), desc="Maximize window"),

    Key([mod, "control", "mod1"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control", "mod1"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control", "mod1"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control", "mod1"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "Tab", focus_expand_next(), desc="Move window focus to next window"),
    Key([mod, "shift"], "Tab", focus_expand_prev(), desc="Move window focus to prev window"),

    Key(
        [mod],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod, "control"], "Return", lazy.window.toggle_floating(), desc='Return from floating'),
    Key([mod], "backslash", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # personal configs
    Key([mod, "control"], "x", lazy.screen.next_group(), desc="Go to next group"),
    Key([mod, "shift"], "x", window_to_next_group(), desc="Send to next group"),
    Key([mod, "control"], "z", lazy.screen.prev_group(), desc="Go to previous group"),
    Key([mod, "shift"], "z", window_to_prev_group(), desc="Send to previous group"),

    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="fullscreen window"),

    Key([mod], "c", lazy.spawn("emacsclient -c -a 'emacs'"), desc="emacs"),
    Key([mod], "p", lazy.spawn("dmenu_run"), desc="dmenu"),
    Key([mod, "mod1"], "p", lazy.spawn("rofi -show run"), desc="rofi-run"),
    Key([mod, "control"], "p", lazy.spawn("rofi -show window"), desc="rofi-window"),
    Key([mod, "mod1"], "f", lazy.spawn("firefox"), desc="Firefox"),
    Key([mod, "mod1"], "b", lazy.spawn("brave"), desc="Brave browser"),
    # Key([mod, "mod1"], "b", lazy.spawn("brave-browser"), desc="Brave browser"),
    Key([], "Print", lazy.spawn("flameshot screen -c"), desc="print"),
    Key([mod], "Print", lazy.spawn("flameshot gui"), desc="print gui"),
    Key([mod, "shift"], "d", lazy.spawn("nemo"), desc="nemo"),
    Key([mod, "control"], "v", lazy.spawn("pwvucontrol -t 3"), desc="audio control"),
    Key([mod, "control"], "a", lazy.spawn("authy"), desc="authenticator"),
]

personalenv = "wertgs"

groups = [Group(i) for i in personalenv]

personallabel = ['www', 'env', 'reconnaissance', 'tools', 'gaming', 'ssh']

# for i in groups:
for i, label in zip(groups, personallabel):
    i.label = label
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.MonadTall(**pclayout),
    layout.Stack(num_stacks=1,**pclayout),
    layout.MonadThreeCol(ratio=0.35,main_centered=False,new_client_position="after_current",**pclayout),
    layout.VerticalTile(**pclayout),
    layout.Spiral(new_client_position="bottom",**pclayout),
    layout.Matrix(**pclayout),
    layout.Floating(**pclayout),
    # layout.MonadWide(**pclayout),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.Zoomy(**pclayout),
]

widget_defaults = dict(
    font=fontdefault,
    fontsize=fontsize,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    foreground=f"#{ bg_color }"
                ),
                widget.CurrentLayoutIcon(),
                widget.GroupBox(
                    highlight_method="line",
                    this_current_screen_border=defaultcolor['primary'],
                    this_screen_border=defaultcolor['primary'],
                    highlight_color=['222222'],
                    inactive=['777777'],
                ),
                widget.Prompt(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.WindowName(
                    font=f"{fontdefault} Bold",
                    padding=4,
                    background=defaultcolor['primary'],
                    foreground=defaultcolor['black'],
                    scroll=True,
                    width=255,
                    # max_chars=32
                ),
                widget.Spacer(),
                widget.Clock(
                    font=f"{fontdefault} Bold",
                    format="%d/%m/%Y %H:%M %p"
                ),
                widget.Spacer(),
                widget.Clipboard(
                    scroll=True,
                    width=255,
                    font=f"{fontdefault} Bold",
                    padding=5,
                ),
                widget.Systray(
                ),
                widget.Spacer(length=6),
                widget.Mpris2(
                    font=f"{fontdefault} Bold",
                    background=defaultcolor['primary'],
                    width=255,
                    padding=6,
                ),
                widget.NvidiaSensors(
                    fmt='nvidia {}',
                    font=f"{fontdefault} Bold",
                    background=defaultcolor['secondary'],
                    padding=6,
                ),
                widget.Net(
                    # interface=['wlp14s0', 'enp20s0'],
                    interface=get_up_if(),
                    font=f"{fontdefault}",
                    padding=10,
                    # format='<b>{interface}: {down}   {up}</b>',
                    format='<b>{down}   {up}</b>',
                    background=defaultcolor['primary'],
                    foreground=defaultcolor['black'],
                ),
                widget.Memory(
                    # measure_mem='G',
                    font=f"{fontdefault} Bold",
                    background=defaultcolor['secondary'],
                    padding=6,
                ),
                widget.Volume(
                    fmt="\uF028 {}",
                    padding=3,
                    background=defaultcolor['primary'],
                    foreground=defaultcolor['black'],
                    fontsize=13,
                    mouse_callbacks={
                        "Button1": lazy.spawn("pwvucontrol -t 3")
                    }
                ),
                widget.Sep(
                    background=defaultcolor['primary'],
                    foreground=defaultcolor['primary'],
                ),
                widget.Sep(
                    foreground=bg_color,
                ),
                widget.QuickExit(
                    default_text='\u23FB',
                    countdown_start=2,
                    countdown_format='{}',
                    font=fontemoji,
                    padding=6
                ),
                widget.Spacer(length=4)
            ],
            20,
            background=f"#{bg_color}",
            border_width=[0, 2, 0, 0],  # Draw top and bottom borders
            border_color=[
                "000000",
                defaultcolor["primary"],
                "ff00ff",
                defaultcolor["primary"]
            ]  # Borders are magenta
        ),
        # bottom=bar.Gap(6),
        # left=bar.Gap(6),
        # right=bar.Gap(6),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod, "control"], "Button1", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button1", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = "floating_only"
cursor_warp = False
floating_layout = layout.Floating(
    **pclayout,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        # Match(wm_class="pwvucontrol"),  # pwvucontrol to floating
        # Match(wm_class="Devtools",role="toolbox"), #
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~' + startupfile)
    subprocess.Popen([home])
