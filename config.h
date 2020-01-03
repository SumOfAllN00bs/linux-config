/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "iosevka-thin:size=11" };
static const char dmenufont[]       = "iosevka-thin:size=11";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "St",       NULL,       NULL,       1 << 2,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size 0.05..0.95 */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect hints in tiled resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "👁 ",       monocle }, /* first entry is default */
	{ "🀱 ",       tile },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,       {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,        {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,  {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define SPAWN(cmd) { .v = (const char*[]){ "st", "-e", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* part of dmenucmd manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon,
                                               "-fn", dmenufont,
                                               "-nb", col_gray1,
                                               "-nf", col_gray3,
                                               "-sb", col_cyan,
                                               "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", "-e", "tmux", NULL};

static Key keys[] = {
	/* modifier           key              function        argument */
	{ MODKEY,             XK_d,            spawn,          {.v = dmenucmd } },
    { MODKEY,             XK_Return,       spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,   XK_t,            spawn,          SPAWN("trc") },
	{ MODKEY|ShiftMask,   XK_n,            spawn,          SPAWN("newsboat") },
	{ MODKEY|ShiftMask,   XK_r,            spawn,          SPAWN("ranger") },
	{ MODKEY|ShiftMask,   XK_w,            spawn,          SHCMD("chromium") },
	{ MODKEY|ShiftMask,   XK_semicolon,    spawn,          SPAWN("ncmpcpp") },
	{ MODKEY|ShiftMask,   XK_p,            spawn,          SHCMD("mpc toggle")},
	{ MODKEY|ShiftMask,   XK_a,            spawn,          SHCMD("ashuffle")},
	{ MODKEY,             XF86XK_Launch5,  spawn,          SHCMD("blender")},
	{ MODKEY,             XF86XK_Launch6,  spawn,          SHCMD("gimp")},
	{ MODKEY,             XF86XK_Launch7,  spawn,          SHCMD("lmms")},
	{ MODKEY,             XF86XK_Launch8,  spawn,          SHCMD("audacity")},
	{ MODKEY,             XF86XK_Launch9,  spawn,          SHCMD("code")},
	{ MODKEY,             XK_b,            togglebar,      {0} },
	{ MODKEY,             XK_h,            focusstack,     {.i = +1 } },
	{ MODKEY,             XK_l,            focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,   XK_i,            incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,   XK_d,            incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,   XK_h,            setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,   XK_l,            setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,   XK_f,            zoom,           {0} },
	{ MODKEY,             XK_f,            togglefloating, {0} },
	{ MODKEY,             XK_Tab,          view,           {0} },
	{ MODKEY,             XK_c,            killclient,     {0} },
	{ MODKEY,             XK_m,            setlayout,      {.v = &layouts[0]}},
	{ MODKEY|ShiftMask,   XK_m,            setlayout,      {.v = &layouts[1]}},
	{ MODKEY,             XK_0,            view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,   XK_0,            tag,            {.ui = ~0 } },
	{ MODKEY,             XK_space,        focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,   XK_space,        tagmon,         {.i = +1 } },
	{ MODKEY,             XK_parenleft,    view,           {.ui = 1 << 0} },
	{ MODKEY|ControlMask, XK_parenleft,    tag,            {.ui = 1 << 0} },
	{ MODKEY,             XK_parenright,   view,           {.ui = 1 << 1} },
	{ MODKEY|ControlMask, XK_parenright,   tag,            {.ui = 1 << 1} },
	{ MODKEY,             XK_braceright,   view,           {.ui = 1 << 2} },
	{ MODKEY|ControlMask, XK_braceright,   tag,            {.ui = 1 << 2} },
	{ MODKEY,             XK_plus,         view,           {.ui = 1 << 3} },
	{ MODKEY|ControlMask, XK_plus,         tag,            {.ui = 1 << 3} },
	{ MODKEY,             XK_braceleft,    view,           {.ui = 1 << 4} },
	{ MODKEY|ControlMask, XK_braceleft,    tag,            {.ui = 1 << 4} },
	{ MODKEY,             XK_bracketright, view,           {.ui = 1 << 5} },
	{ MODKEY|ControlMask, XK_bracketright, tag,            {.ui = 1 << 5} },
	{ MODKEY,             XK_bracketleft,  view,           {.ui = 1 << 6} },
	{ MODKEY|ControlMask, XK_bracketleft,  tag,            {.ui = 1 << 6} },
	{ MODKEY,             XK_exclam,       view,           {.ui = 1 << 7} },
	{ MODKEY|ControlMask, XK_exclam,       tag,            {.ui = 1 << 7} },
	{ MODKEY,             XK_equal,        view,           {.ui = 1 << 8} },
	{ MODKEY|ControlMask, XK_equal,        tag,            {.ui = 1 << 8} },
	{ MODKEY,             XK_Escape,       quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol,
   ClkStatusText, ClkWinTitle, ClkClientWin,
   or ClkRootWin */
static Button buttons[] = {
	/* click         event mask button   function        argument */
	{ ClkLtSymbol,   0,         Button1, setlayout,      {0} },
	{ ClkLtSymbol,   0,         Button3, setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,   0,         Button2, zoom,           {0} },
	{ ClkStatusText, 0,         Button1, spawn,          SPAWN("pulsemixer") },
	{ ClkStatusText, 0,         Button2, spawn,          {.v = termcmd } },
	{ ClkStatusText, 0,         Button4, spawn,          SHCMD("vupcmd") },
	{ ClkStatusText, 0,         Button5, spawn,          SHCMD("vdowncmd") },
	{ ClkClientWin,  MODKEY,    Button1, movemouse,      {0} },
	{ ClkClientWin,  MODKEY,    Button2, togglefloating, {0} },
	{ ClkClientWin,  MODKEY,    Button3, resizemouse,    {0} },
	{ ClkTagBar,     0,         Button1, view,           {0} },
	{ ClkTagBar,     0,         Button3, toggleview,     {0} },
	{ ClkTagBar,     MODKEY,    Button1, tag,            {0} },
	{ ClkTagBar,     MODKEY,    Button3, toggletag,      {0} },
};

