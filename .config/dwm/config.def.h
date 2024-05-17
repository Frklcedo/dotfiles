/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 8;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 20;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */

static const int horizpadbar        = 4;        /* horizontal padding for statusbar */
static const int vertpadbar         = 0;        /* vertical padding for statusbar */

static const char *fonts[]          = { 
  "Ubuntu Nerd Font:weight=medium:size=12:antialias=true:autohint=true",
  "Symbols Nerd Font Mono:size=12:antialias=true:autohint=true",
  "monospace:size=12:antialias=true:autohint=true"
};
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#202020";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";

static const char cprimary[]       = "#FF90BE";
static const char csecond[]       = "#6B6EBF";
static const char cwhite[]       = "#ffffff";
static const char cblack[]       = "#282c34";
static const char cblack_bright[]       = "#5c6370";
static const char cblack_dark[] = "#1e2127";

static const unsigned int baralpha = 0xff;
static const unsigned int borderalpha = OPAQUE;

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { cwhite, cblack, csecond },
	[SchemeSel]  = { cblack, cprimary, cprimary },

	[SchemeWarn] =	 { cwhite, csecond, csecond },
	[SchemeUrgent]=	 { cblack, cprimary, cprimary },
	[SchemeStatus]  = { cwhite, cblack,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { cblack, cprimary,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm]  = { cwhite, cblack,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]  = { cwhite, cblack,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]  = { cwhite, cblack_dark,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}

};

static const unsigned int alphas[][3]      = {
    /*               fg      bg        border*/
  [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },

  [SchemeWarn]  = { OPAQUE, baralpha, borderalpha },
  [SchemeUrgent]  = { OPAQUE, baralpha, borderalpha },
	[SchemeStatus]  = { OPAQUE, baralpha, borderalpha }, 
	[SchemeTagsSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeTagsNorm]  = { OPAQUE, baralpha, borderalpha },
	[SchemeInfoSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeInfoNorm]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "www", "env", "reconnaissance", "tasks", "ssh", "dev", "free", "gaming", "vm" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor   border width */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1,       -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1,       -1 },
	{ "trayer",  "panel",       "panel",       0,       1,           -1,       0 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
  { "|M|",      centeredmaster },
  { ">M>",      centeredfloatingmaster },
  { "><>",      NULL },    /* no layout function means floating behavior */
};

static void changetotag(const Arg *arg); 

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG)                                                                                               \
  &((Keychord){1, { {MODKEY, KEY} }, view, {.ui = 1 << TAG} }), \
  &((Keychord){1, { {MODKEY|ShiftMask, KEY} }, changetotag, {.ui = 1 << TAG} }), \
  &((Keychord){1, { {MODKEY|ControlMask, KEY} }, tag, {.ui = 1 << TAG} }), \
  &((Keychord){2, { {MODKEY, XK_0}, {MODKEY, KEY} }, toggleview, {.ui = 1 << TAG} }), \
  &((Keychord){2, { {MODKEY, XK_0}, {0, KEY} }, toggletag,      {.ui = 1 << TAG} }),

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static Keychord *keychords[] = {
	/* modifier, key, function, argument */
  // &((Keychord){1, {{MODKEY, XK_p}}, spawn,          {.v = dmenucmd } }),
	&((Keychord){1, { {MODKEY, XK_p} }, spawn, SHCMD("dmenu_run") }),
  &((Keychord){1, { {MODKEY|ShiftMask, XK_p} }, spawn, {.v = dmenucmd } }),
	&((Keychord){1, { {MODKEY, XK_j} }, focusstack, {.i = +1 } }),
	&((Keychord){1, { {MODKEY, XK_k} }, focusstack, {.i = -1 } }),
  &((Keychord){1, { {MODKEY, XK_h} }, setmfact, {.f = -0.05} }),
  &((Keychord){1, { {MODKEY, XK_l} }, setmfact, {.f = +0.05} }),
  &((Keychord){1, { {MODKEY|ControlMask, XK_h} }, incnmaster, {.i = +1 } }),
  &((Keychord){1, { {MODKEY|ControlMask, XK_l} }, incnmaster, {.i = -1 } }),

  &((Keychord){1, { {MODKEY, XK_backslash} }, spawn, {.v = termcmd } }),
	&((Keychord){1, { {MODKEY|ShiftMask, XK_c} }, killclient, {0} }),

	&((Keychord){1, { {MODKEY, XK_Return} }, zoom, {0} }),
  &((Keychord){1, { {MODKEY, XK_b} }, togglebar, {0} }),
	&((Keychord){1, { {MODKEY, XK_Tab} }, view, {0} }),
	&((Keychord){2, { {MODKEY|ShiftMask, XK_q}, {0, XK_q} }, quit, {0} }),
	&((Keychord){2, { {MODKEY|ShiftMask, XK_q}, {0, XK_r} }, quit, {1} }),

  /* applications */
	&((Keychord){1, { {MODKEY|Mod1Mask, XK_f} }, spawn, SHCMD("firefox") }),

	&((Keychord){1, { {0, XK_Print} }, spawn, SHCMD("flameshot screen -c") }),
	&((Keychord){1, { {MODKEY, XK_Print} }, spawn, SHCMD("flameshot gui") }),

	&((Keychord){2, { {MODKEY, XK_o}, {MODKEY, XK_d} }, spawn, SHCMD("nemo") }),
	&((Keychord){2, { {MODKEY, XK_o}, {MODKEY, XK_v} }, spawn, SHCMD("pavucontrol -t 3") }),

	&((Keychord){2, { {MODKEY, XK_o}, {MODKEY, XK_t} }, spawn, SHCMD("trayer --edge top --iconspacing 3 --expand false --width 60 --height 20") }),
      


  /* layouts */
	&((Keychord){2, { {MODKEY, XK_space}, {MODKEY, XK_w} }, setlayout, {.v = &layouts[0]} }),
  &((Keychord){2, { {MODKEY, XK_space}, {MODKEY, XK_e} }, setlayout, {.v = &layouts[1]} }),
	&((Keychord){2, { {MODKEY, XK_space}, {MODKEY, XK_r} }, setlayout, {.v = &layouts[2]} }),
  &((Keychord){2, { {MODKEY, XK_space}, {MODKEY, XK_t} }, setlayout, {.v = &layouts[3]} }),
	&((Keychord){2, { {MODKEY, XK_space}, {MODKEY, XK_g} }, setlayout, {.v = &layouts[4]} }),
	&((Keychord){2, { {MODKEY, XK_space}, {MODKEY, XK_space} }, setlayout, {0} }),
	&((Keychord){1, { {MODKEY|ShiftMask, XK_Return} }, togglefloating, {0} }),

  /* select tags */
	&((Keychord){2, { {MODKEY, XK_0}, {MODKEY, XK_f} }, view, {.ui = ~0 } }),
  /* fix window */
	&((Keychord){2, { {MODKEY, XK_0}, {MODKEY|ControlMask, XK_f} }, tag, {.ui = ~0 } }),

  /* monitor */
	&((Keychord){1, { {MODKEY, XK_comma} }, focusmon, {.i = -1 } }),
	&((Keychord){1, { {MODKEY, XK_period} }, focusmon, {.i = +1 } }),
	&((Keychord){1, { {MODKEY|ShiftMask, XK_comma} }, tagmon, {.i = -1 } }),
	&((Keychord){1, { {MODKEY|ShiftMask, XK_period} }, tagmon, {.i = +1 } }),

  /* tags */
	TAGKEYS(                        XK_w,                      0)
	TAGKEYS(                        XK_e,                      1)
	TAGKEYS(                        XK_r,                      2)
	TAGKEYS(                        XK_t,                      3)
	TAGKEYS(                        XK_s,                      4)
	TAGKEYS(                        XK_d,                      5)
	TAGKEYS(                        XK_f,                      6)
	TAGKEYS(                        XK_g,                      7)
	TAGKEYS(                        XK_v,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

/* custom functions */
void
changetotag(const Arg *arg) {
  tag(arg);
  view(arg);
}

