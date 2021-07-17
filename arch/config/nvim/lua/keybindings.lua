-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- \q = Quit all buffers
-- \x = Write all buffers and quit
vim.api.nvim_set_keymap('n', '<Bslash>q', [[<Cmd>q<CR><Cmd>q<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Bslash>x', [[<Cmd>wqa<CR>]], { noremap = true, silent = true })

-- TrueZen --
-- Leader1 = Ataraxis mode
-- Leader2 = Resize Ataraxis mode
-- Leader3 = Minimalist mode
-- Leader4 = Focus mode
vim.api.nvim_set_keymap('n', '<Leader>1', [[<Cmd>TZAtaraxis<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>2', [[<Cmd>TZAtaraxis<CR><Cmd>TZAtaraxis<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>3', [[<Cmd>TZMinimalist<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>4', [[<Cmd>TZFocus<CR>]], { noremap = true, silent = true })

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
