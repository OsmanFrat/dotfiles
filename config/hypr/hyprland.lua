-- =========================================================
-- MONITORS
-- =========================================================

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})


-- =========================================================
-- MY PROGRAMS
-- =========================================================

local terminal = "kitty"
local browser = "firefox"
local fileManager = "thunar"
local menu = "rofi -show"
local neovide = "neovide"

local hyprshot_region_copy =
    "hyprshot -s -m region --clipboard-only"

local hyprshot_fullscreen_copy =
    "hyprshot -m output -m eDP-1 --clipboard-only -z"

local hyprshot_fullscreen_save =
    "hyprshot -m output -m eDP-1 -o /home/ozu/Pictures/Screenshots/"


-- =========================================================
-- AUTOSTART
-- =========================================================

hl.exec_once("nm-applet")
hl.exec_once("waybar")
hl.exec_once("hyprpaper")
hl.exec_once("systemctl --user start hyprpolkitagent")
hl.exec_once("systemctl --user start emacs.service")
hl.exec_once("wl-paste --type text --watch clipman store")

-- İstersen:
-- hl.exec_once("mpd")
-- hl.exec_once("emacs --daemon")


-- =========================================================
-- ENVIRONMENT VARIABLES
-- =========================================================

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    ecosystem = {
        no_update_news = true,
    },
})


-- =========================================================
-- LOOK AND FEEL
-- =========================================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 2,

        color = {
            colors = {
                "rgba(33ccffee)",
                "rgba(00ff99ee)",
            },
            angle = 45,
        },

        color_inactive = "rgba(595959aa)",

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 5,

        active_opacity = 0.9,
        inactive_opacity = 0.94,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    dwindle = {
        -- pseudotile = true
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,

        enable_swallow = true,
        swallow_regex = "^(Alacritty|kitty)$",
        swallow_exception_regex = "^(Neovim|ueberzugpp.*)$",
    },
})


-- =========================================================
-- ANIMATIONS
-- =========================================================

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default",
})

hl.curve("easeOutQuint", {
    type = "bezier",
    points = {
        { 0.23, 1 },
        { 0.32, 1 },
    },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = {
        { 0.65, 0.05 },
        { 0.36, 1 },
    },
})

hl.curve("linear", {
    type = "bezier",
    points = {
        { 0, 0 },
        { 1, 1 },
    },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = {
        { 0.5, 0.5 },
        { 0.75, 1.0 },
    },
})

hl.curve("quick", {
    type = "bezier",
    points = {
        { 0.15, 0 },
        { 0.1, 1 },
    },
})


hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%",
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick",
})

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade",
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade",
})

hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear",
})

hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade",
})

hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1.21,
    bezier = "almostLinear",
    style = "fade",
})

hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade",
})


-- =========================================================
-- INPUT
-- =========================================================

hl.config({
    input = {
        kb_layout = "us,tr",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:swapescape,altwin:swap_alt_win",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})


hl.config({
    gestures = {
        workspace_swipe = true,
    },
})


hl.config({
    device = {
        name = "epic-mouse-v1",
        sensitivity = -0.5,
    },
})


-- =========================================================
-- KEYBINDINGS
-- =========================================================

local mainMod = "SUPER"


-- ---------------------------------------------------------
-- Programs
-- ---------------------------------------------------------

hl.bind(mainMod .. " + W",
    hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + Q",
    hl.dsp.window.kill())

hl.bind(mainMod .. " + SHIFT + M",
    hl.dsp.exit())

hl.bind(mainMod .. " + E",
    hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + SPACE",
    hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + P",
    hl.dsp.window.pseudo())

hl.bind(mainMod .. " + F",
    hl.dsp.window.fullscreen())

hl.bind("ALT + SHIFT + S",
    hl.dsp.exec_cmd(hyprshot_region_copy))

hl.bind("ALT + SHIFT + PRINT",
    hl.dsp.exec_cmd(hyprshot_fullscreen_copy))

hl.bind("ALT + PRINT",
    hl.dsp.exec_cmd(hyprshot_fullscreen_save))

hl.bind(mainMod .. " + R",
    hl.dsp.exec_cmd('emacsclient -c -n -a ""'))

hl.bind(mainMod .. " + B",
    hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

hl.bind(mainMod .. " + U",
    hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. " + RETURN",
    hl.dsp.exec_cmd(neovide))


-- ---------------------------------------------------------
-- Focus
-- ---------------------------------------------------------

hl.bind(mainMod .. " + H",
    hl.dsp.focus("l"))

hl.bind(mainMod .. " + L",
    hl.dsp.focus("r"))

hl.bind(mainMod .. " + K",
    hl.dsp.focus("u"))

hl.bind(mainMod .. " + J",
    hl.dsp.focus("d"))


-- ---------------------------------------------------------
-- Move windows
-- ---------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + H",
    hl.dsp.window.move("l"))

hl.bind(mainMod .. " + SHIFT + L",
    hl.dsp.window.move("r"))

hl.bind(mainMod .. " + SHIFT + K",
    hl.dsp.window.move("u"))

hl.bind(mainMod .. " + SHIFT + J",
    hl.dsp.window.move("d"))


-- ---------------------------------------------------------
-- Resize
-- ---------------------------------------------------------

hl.bind(mainMod .. " + CTRL + L",
    hl.dsp.window.resize_active({ 50, 0 }))

hl.bind(mainMod .. " + CTRL + H",
    hl.dsp.window.resize_active({ -50, 0 }))

hl.bind(mainMod .. " + CTRL + K",
    hl.dsp.window.resize_active({ 0, -50 }))

hl.bind(mainMod .. " + CTRL + J",
    hl.dsp.window.resize_active({ 0, 50 }))


-- ---------------------------------------------------------
-- Workspaces
-- ---------------------------------------------------------

for i = 1, 9 do
    hl.bind(
        mainMod .. " + " .. i,
        hl.workspace(i)
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({
            workspace = i,
        })
    )
end

-- 0 -> workspace 10
hl.bind(mainMod .. " + 0",
    hl.workspace(10))

hl.bind(mainMod .. " + SHIFT + 0",
    hl.dsp.window.move({
        workspace = 10,
    }))


-- ---------------------------------------------------------
-- Workspace switcher
-- ---------------------------------------------------------

hl.bind(
    mainMod .. " + TAB",
    hl.dsp.exec_cmd(
        "/home/ozu/.config/hypr/switch_workspaces.sh"
    )
)


-- ---------------------------------------------------------
-- Translation
-- ---------------------------------------------------------

hl.bind(
    mainMod .. " + D",
    hl.dsp.exec_cmd(
        "/home/ozu/dotfiles/scripts/translate.sh"
    )
)


-- ---------------------------------------------------------
-- Special workspace
-- ---------------------------------------------------------

hl.bind(
    mainMod .. " + S",
    hl.dsp.workspace("special:magic")
)

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({
        workspace = "special:magic",
    })
)


-- ---------------------------------------------------------
-- Scroll workspaces
-- ---------------------------------------------------------

hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.workspace("e+1")
)

hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.workspace("e-1")
)


-- ---------------------------------------------------------
-- Mouse move / resize
-- ---------------------------------------------------------

hl.bindm(
    mainMod,
    "mouse:272",
    hl.dsp.window.move()
)

hl.bindm(
    mainMod,
    "mouse:273",
    hl.dsp.window.resize()
)


-- ---------------------------------------------------------
-- Volume / brightness
-- ---------------------------------------------------------

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ),
    { repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ),
    { repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ),
    { repeating = true }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ),
    { repeating = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl s 10%+"
    ),
    { repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl s 10%-"
    ),
    { repeating = true }
)


-- ---------------------------------------------------------
-- Media keys
-- ---------------------------------------------------------

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next")
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause")
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause")
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous")
)


-- =========================================================
-- WINDOWS AND WORKSPACES
-- =========================================================

hl.window_rule({
    match = {
        title = ".*YouTube.*",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        title = ".*Discord.*",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "firefox",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "mpv",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "Emacs",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "steam",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        class = "syncplay",
    },
    opacity = "1 1",
})

hl.window_rule({
    match = {
        title = ".*Emacs.*",
    },
    opacity = "1 1",
})

-- Eski conf dosyandaki diğer windowrule'lar
-- zaten yorum satırı olduğu için eklenmedi.
