local hl = vim.api.nvim_set_hl

-- Vertical separator
hl(0, "VertSplit", { cterm = vim.empty_dict() })

-- Sign column
hl(0, "SignColumn", { ctermbg = 0 })
hl(0, "DiffAdd",    { ctermbg = 0 })
hl(0, "DiffDelete", { ctermbg = 0 })
hl(0, "DiffChange", { ctermbg = 0 })
hl(0, "DiffText",   { ctermbg = 0 })
