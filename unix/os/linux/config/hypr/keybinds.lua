local mainMod  = "SUPER"
local terminal = "ghostty"
local menu     = "fuzzel"

-- VoxType (Speech-to-text)
hl.bind("ALT + Space", hl.dsp.exec_cmd("voxtype record start"))
hl.bind("ALT + Space", hl.dsp.submap("voxtype_recording"))
hl.define_submap("voxtype_recording", function()
    hl.bind("ALT + Space", hl.dsp.exec_cmd("voxtype record stop"))
    hl.bind("ALT + Space", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.exec_cmd("voxtype record cancel"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("edit-in-nvim.sh"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))

-- Bar submap
hl.bind("ALT + B", hl.dsp.submap("bar"))
hl.define_submap("bar", function()
    hl.bind("B", hl.dsp.exec_cmd("blueman-manager"))
    hl.bind("B", hl.dsp.submap("reset"))
    hl.bind("W", hl.dsp.exec_cmd("ghostty --title=nmtui-connect --command=nmtui-connect"))
    hl.bind("W", hl.dsp.submap("reset"))
    hl.bind("H", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
    hl.bind("left", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
    hl.bind("L", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
    hl.bind("right", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
    hl.bind("J", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
    hl.bind("down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
    hl.bind("K", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
    hl.bind("up", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
    hl.bind("M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Resize windows submap
hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0 }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0 }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10 }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10 }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Power menu submap
hl.bind("ALT + Q", hl.dsp.submap("power"))
hl.define_submap("power", function()
    hl.bind("Q", hl.dsp.exec_cmd("shutdown now"))
    hl.bind("Q", hl.dsp.submap("reset"))
    hl.bind("L", hl.dsp.exec_cmd("physlock"))
    hl.bind("L", hl.dsp.submap("reset"))
    hl.bind("S", hl.dsp.exec_cmd("systemctl suspend"))
    hl.bind("S", hl.dsp.submap("reset"))
    hl.bind("R", hl.dsp.exec_cmd("reboot"))
    hl.bind("R", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Screenshot submap
hl.bind(mainMod .. " + S", hl.dsp.submap("screenshot"))
hl.define_submap("screenshot", function()
    -- Fullscreen
    hl.bind("F", hl.dsp.exec_cmd("grimblast copysave screen $HOME/Media/screenshots/full/$(date +'%F-%T.png')"))
    hl.bind("F", hl.dsp.submap("reset"))
    -- Selected area
    hl.bind("S", hl.dsp.exec_cmd("grimblast copysave area $HOME/Media/screenshots/area/$(date +'%F-%T.png')"))
    hl.bind("S", hl.dsp.submap("reset"))
    -- Active window
    hl.bind("A", hl.dsp.exec_cmd("grimblast copysave active $HOME/Media/screenshots/active/$(date +'%F-%T.png')"))
    hl.bind("A", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Workspaces

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + P", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
