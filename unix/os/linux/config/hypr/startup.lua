hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload -n")                 -- Reload Hyprland plugins
    hl.exec_cmd("hypridle")                         -- Idle manager
    -- hl.exec_cmd("waydroid session start")        -- Start waydroid

    hl.exec_cmd("waybar")                           -- Status bar
    hl.exec_cmd("dunst")                            -- Notification daemon
    hl.exec_cmd("hyprpaper")                        -- Wallpaper manager
    hl.exec_cmd("zen-browser", { workspace = "1 silent" })
    hl.exec_cmd("ghostty -e \"zellij\" attach default", { workspace = "6 silent" })
end)
