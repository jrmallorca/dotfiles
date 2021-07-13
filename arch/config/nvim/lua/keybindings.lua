-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Write all buffers and quit
vim.api.nvim_set_keymap('n', '<Bslash>q', [[<Cmd>wqa<CR>]], { noremap = true, silent = true })

-- TrueZen --
-- Leader + 1 = Ataraxis mode
-- Leader + 2 = Focus mode
vim.api.nvim_set_keymap('n', '<leader>1', [[<Cmd>TZAtaraxis<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', [[<Cmd>TZFocus<CR>]], { noremap = true, silent = true })
