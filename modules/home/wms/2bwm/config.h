#define MOD ALT

/* cursor position: 
   TOP_LEFT MIDDLE TOP_RIGHT
   BOTTOM_LEFT  BOTTOM_RIGHT */
#define CURSOR_POSITION MIDDLE

// ignore bar
#define LOOK_INTO "WM_NAME"
static const char *ignore_names[] = { "xclock" };

/* movements:
   0)move slow   1)move fast
   2)mouse slow  3)mouse fast */
static const uint16_t movements[] = {50,100,50,100};
static const bool     resize_by_line                = true;
static const float    resize_keep_aspect_ratio      = 1.03;

/* offsets:
   0)offsetx    1)offsety
   2)maxwidth   3)maxheight */
static const uint8_t offsets[] = {0,20,0,20};

/* borders:
   0)outer    1)full
   2)magnet   3)resize */
static const uint8_t borders[] = {9,12,12,12};
static const bool inverted_colors = false;
static const char *colors[] = {
    "#FC8EBD", // active
    "#262626", // inactive
    "#262626", // fixed
    "#000000", // unkillable
    "#000000", // fixed unkillable
    "#000000", // outer
    "#000000"  // empty
}; 

// commands
static const char *windowcmd[]    = { "9icon", NULL };
static const char *dmenucmd[]     = { "drun", NULL };
static const char *termcmd[]      = { "alacritty", NULL };

// custom functions
static void halfandcentered(const Arg *arg)
{
    Arg arg2 = {.i=TWOBWM_MAXHALF_VERTICAL_LEFT};
    maxhalf(&arg2);
    Arg arg3 = {.i=TWOBWM_TELEPORT_CENTER};
    teleport(&arg3);
}

/* max with borders function:
   quite hacky, have to use "vertmaxed"
   to get around setborders ignoring windows
   with the "maxed" attribute as they normally
   hide those borders                          */
static void maxwithborders(const Arg *arg)
{
    uint32_t values[4];
    int16_t mon_y, mon_x, temp=0;
    uint16_t mon_height, mon_width;
    
    if (NULL == focuswin)
        return;

    if (focuswin->vertmaxed || focuswin->maxed) {
        unmax(focuswin);
        focuswin->vertmaxed = focuswin->maxed = false;
        fitonscreen(focuswin);
        setborders(focuswin, true);
        return;
    }

    getmonsize(1, &mon_x,&mon_y,&mon_width,&mon_height,focuswin);
    saveorigsize(focuswin);
    noborder(&temp, focuswin,true);

    focuswin->x = mon_x;
    focuswin->y = mon_y;
    focuswin->width = mon_width - (conf.borderwidth * 2);
    focuswin->height = mon_height - (conf.borderwidth * 2);

    values[0] = focuswin->x; 
    values[1] = focuswin->y;
    values[2] = focuswin->width;
    values[3] = focuswin->height;    

    xcb_configure_window(conn, focuswin->id, XCB_CONFIG_WINDOW_X
            | XCB_CONFIG_WINDOW_Y | XCB_CONFIG_WINDOW_WIDTH
            | XCB_CONFIG_WINDOW_HEIGHT, values);

    focuswin->vertmaxed = true;

    noborder(&temp, focuswin,false);
    raise_current_window();
    centerpointer(focuswin->id,focuswin);
    setborders(focuswin,true);
}

// key bindings
#define DESKTOPCHANGE(K,N) \
{  MOD ,             K,              changeworkspace, {.i=N}}, \
{  MOD |SHIFT,       K,              sendtoworkspace, {.i=N}},
static key keys[] = {
    {  MOD ,              XK_q,          deletewin,         {}},
    {  MOD ,              XK_Escape,     twobwm_restart,    {.i=0}},
    {  MOD |CONTROL|SHIFT,XK_Escape,     twobwm_exit,       {.i=0}},

    {  MOD ,              XK_r,          raiseorlower,      {}},
    {  MOD ,              XK_Tab,        focusnext,         {.i=TWOBWM_FOCUS_NEXT}},
    {  MOD |SHIFT,        XK_Tab,        focusnext,         {.i=TWOBWM_FOCUS_PREVIOUS}},

    {  MOD ,              XK_f,          maxwithborders,    {}},
    {  MOD |SHIFT ,       XK_f,          fullscreen,        {}},
    {  MOD ,              XK_v,          maxvert_hor,       {.i=TWOBWM_MAXIMIZE_VERTICALLY}},
    {  MOD |SHIFT,        XK_v,          maxvert_hor,       {.i=TWOBWM_MAXIMIZE_HORIZONTALLY}},

    {  MOD ,              XK_space,      halfandcentered,   {.i=0}},
    
    {  MOD ,              XK_g,          teleport,          {.i=TWOBWM_TELEPORT_CENTER}},
    {  MOD ,              XK_y,          teleport,          {.i=TWOBWM_TELEPORT_TOP_LEFT}},
    {  MOD ,              XK_u,          teleport,          {.i=TWOBWM_TELEPORT_TOP_RIGHT}},
    {  MOD ,              XK_b,          teleport,          {.i=TWOBWM_TELEPORT_BOTTOM_LEFT}},
    {  MOD ,              XK_n,          teleport,          {.i=TWOBWM_TELEPORT_BOTTOM_RIGHT}},

    {  MOD ,              XK_h,          movestep,          {.i=TWOBWM_MOVE_LEFT}},
    {  MOD ,              XK_j,          movestep,          {.i=TWOBWM_MOVE_DOWN}},    
    {  MOD ,              XK_k,          movestep,          {.i=TWOBWM_MOVE_UP}},
    {  MOD ,              XK_l,          movestep,          {.i=TWOBWM_MOVE_RIGHT}},
    {  MOD |SHIFT,        XK_h,          resizestep,        {.i=TWOBWM_RESIZE_LEFT}},
    {  MOD |SHIFT,        XK_j,          resizestep,        {.i=TWOBWM_RESIZE_DOWN}},
    {  MOD |SHIFT,        XK_k,          resizestep,        {.i=TWOBWM_RESIZE_UP}},
    {  MOD |SHIFT,        XK_l,          resizestep,        {.i=TWOBWM_RESIZE_RIGHT}},

    // {  MOD ,              XK_a,          unkillable,        {}},
    // {  MOD,               XK_t,          always_on_top,     {}},

    {  MOD ,              XK_w,          start,             {.com = windowcmd}},
    {  MOD ,              XK_d,          start,             {.com = dmenucmd}},
    {  MOD ,              XK_Return,     start,             {.com = termcmd}},

       DESKTOPCHANGE(     XK_1,                             0)
       DESKTOPCHANGE(     XK_2,                             1)
       DESKTOPCHANGE(     XK_3,                             2)
       DESKTOPCHANGE(     XK_4,                             3)
    // DESKTOPCHANGE(     XK_5,                             4)
    // DESKTOPCHANGE(     XK_6,                             5)
    // DESKTOPCHANGE(     XK_7,                             6)
    // DESKTOPCHANGE(     XK_8,                             7)
    // DESKTOPCHANGE(     XK_9,                             8)
    // DESKTOPCHANGE(     XK_0,                             9)
};

// mouse bindings
static Button buttons[] = {
    {  MOD ,      XCB_BUTTON_INDEX_1,     mousemotion,         {.i=TWOBWM_MOVE}, false},
    {  MOD ,      XCB_BUTTON_INDEX_2,     hide,                {}, false},
    {  MOD |SHIFT,XCB_BUTTON_INDEX_2,     fix,                 {}, false},
    {  MOD ,      XCB_BUTTON_INDEX_3,     mousemotion,         {.i=TWOBWM_RESIZE}, false},
    {  0   ,      XCB_BUTTON_INDEX_3,     start,               {.com = windowcmd}, true},
    {  MOD ,      XCB_BUTTON_INDEX_4,     resizestep_aspect,   {.i=TWOBWM_RESIZE_KEEP_ASPECT_GROW}, false},
    {  MOD ,      XCB_BUTTON_INDEX_5,     resizestep_aspect,   {.i=TWOBWM_RESIZE_KEEP_ASPECT_SHRINK}, false},
};
