-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- \w = Save current file
-- \q = Quit
-- \x = Write all buffers and quit
vim.api.nvim_set_keymap('n', '<Bslash>w', [[<Cmd>w<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Bslash>q', [[<Cmd>q<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Bslash>x', [[<Cmd>wqa<CR>]], { noremap = true, silent = true })

-- TrueZen --
-- Leader1 = Ataraxis mode
-- Leader2 = Minimalist mode
-- Leader3 = Focus mode
vim.api.nvim_set_keymap('n', '<Leader>1', [[<Cmd>TZAtaraxisOff<CR><Cmd>TZMinimalistOff<CR><Cmd>TZFocusOff<CR><Cmd>TZAtaraxisOn<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>2', [[<Cmd>TZAtaraxisOff<CR><Cmd>TZMinimalistOff<CR><Cmd>TZFocusOff<CR><Cmd>TZMinimalistOn<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>3', [[<Cmd>TZFocus<CR>]], { noremap = true, silent = true })

-- Snap --
-- \\  = Find files within current and child directories
-- \fb = Find open files in buffers
-- \fo = Find files previously opened in history
-- \/ = Find matching string within current and child directories
local snap = require'snap'
snap.maps {
  {"<Bslash><Bslash>", snap.config.file {producer = "ripgrep.file"}},
  {"<Bslash>fb", snap.config.file {producer = "vim.buffer"}},
  {"<Bslash>fo", snap.config.file {producer = "vim.oldfile"}},
  {"<Bslash>/", snap.config.vimgrep {}},
}

-- Lightspeed
-- Replace 's' with 'f'
vim.api.nvim_set_keymap('n', 'f', [[<Plug>Lightspeed_s]], { silent = true })
vim.api.nvim_set_keymap('n', 'F', [[<Plug>Lightspeed_S]], { silent = true })
