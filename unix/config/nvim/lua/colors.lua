local hl = vim.api.nvim_set_hl

-- Vertical separator
hl(0, "VertSplit", { cterm = vim.empty_dict() })

-- Sign column
hl(0, "SignColumn", { ctermbg = "NONE" })
hl(0, "DiffAdd",    { ctermbg = "NONE" })
hl(0, "DiffDelete", { ctermbg = "NONE" })
hl(0, "DiffChange", { ctermbg = "NONE" })
hl(0, "DiffText",   { ctermbg = "NONE" })
