hl.window_rule({
    match = { class = "blueman-manager" },
    float = true,
})
hl.window_rule({
    match = { class = "com.mitchellh.ghostty", title = "edit-in-nvim.sh" },
    float = true,
})
hl.window_rule({
    match = { class = "com.mitchellh.ghostty", title = "nmtui-connect" },
    float = true,
})
hl.window_rule({
    match = { class = "anki" },
    ["darkwindow:shade"] = "chromakey bkg=[0 0 0] targetOpacity=0.67",
})
