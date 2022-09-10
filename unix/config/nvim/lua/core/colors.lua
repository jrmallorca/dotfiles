local hl = vim.api.nvim_set_hl
local g = vim.g

-- Vertical separator
hl(0, "VertSplit", { cterm = vim.empty_dict() })

-- Status line
hl(0, "StatusLine", { ctermbg="NONE", cterm = vim.empty_dict() })

-- Sign column
hl(0, "SignColumn", { ctermbg = "NONE" })
hl(0, "DiffAdd",    { ctermbg = "NONE" })
hl(0, "DiffDelete", { ctermbg = "NONE" })
hl(0, "DiffChange", { ctermbg = "NONE" })
hl(0, "DiffText",   { ctermbg = "NONE" })

-- Configure Limelight
g.limelight_conceal_ctermfg = 'gray'
g.limelight_conceal_ctermfg = 240
g.limelight_conceal_guifg = 'DarkGray'
g.limelight_conceal_guifg = '#777777'
g.limelight_default_coefficient = 0.9
