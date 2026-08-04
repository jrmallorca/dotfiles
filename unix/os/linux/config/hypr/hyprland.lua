require("startup")
require("env")
require("windowrules")
require("keybinds")
require("input")

-- Monitor
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
})
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "1920x0",
    scale    = 1,
})

-- Workspaces
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", persistent = true })

hl.workspace_rule({ workspace = "6", monitor = "eDP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1", persistent = true })

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(d4be98ee)", "rgba(d8a657ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        layout = "master",

        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
    },

    cursor = {
        inactive_timeout = 3,
    },

    decoration = {
        rounding = 10,
    },

    master = {
        new_status = "master",
        new_on_top = true,
        mfact      = 0.5,
    },

    misc = {
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        enable_swallow             = true,
        swallow_regex              = "^(com.mitchellh.ghostty)$",
        focus_on_activate          = true,
    },

    binds = {
        allow_workspace_cycles = true,
    },
})

-- See https://wiki.hyprland.org/Configuring/Animations/ for more
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })
