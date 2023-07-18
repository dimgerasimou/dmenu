/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int ignoretab = 0;                   /* -a option; ignores tab characters at the begining, and replaces the rest with a space */
static int instant = 0;
static int min_width = 500;                 /* minimum width when centered */
static const unsigned int alpha = 220;

/* -fn option overrides fonts[0]; default X11 font or font set */
static char font[] = { "JetBrains Mono Nerd Font:style=Regular:size=12" };
static const char *fonts[] = {
	font,
	"JoyPixels:style=Regular:size=10",
	"monospace:size=10"
};

static char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

static char normfgcolor[] = "#bbbbbb";
static char normbgcolor[] = "#222222";
static char selfgcolor[]  = "#eeeeee";
static char selbgcolor[]  = "#005577";
static char *colors[SchemeLast][2] = {
	/*                        fg           bg       */
	[SchemeNorm]          = { normfgcolor, normbgcolor },
	[SchemeSel]           = { selfgcolor,  selbgcolor  },
	[SchemeSelHighlight]  = { "#ffc978",   "#005577"   },
	[SchemeNormHighlight] = { "#ffc978",   "#222222"   },
	[SchemeOut]           = { "#000000",   "#00ffff"   },
	[SchemeOutHighlight]  = { "#ffc978",   "#00ffff"   },
};

static unsigned int alphas[SchemeLast][2] = {
	[SchemeNorm] = { OPAQUE, alpha },
	[SchemeSel]  = { OPAQUE, alpha },
	[SchemeOut]  = { OPAQUE, alpha },
};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
	{ "font",        STRING, &font },
	{ "normfgcolor", STRING, &normfgcolor },
	{ "normbgcolor", STRING, &normbgcolor },
	{ "selfgcolor",  STRING, &selfgcolor },
	{ "selbgcolor",  STRING, &selbgcolor },
	{ "prompt",      STRING, &prompt },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 0;
static unsigned int min_lineheight = 8;

static unsigned int shownumbers = 1;

/*
 * Use prefix matching by default; can be inverted with the -x flag.
 */
static int use_prefix = 1;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;
