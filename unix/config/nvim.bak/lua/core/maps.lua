-- If it's a `<Plug>`, then DO NOT do `noremap = true`

-- Modes --
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Do not format on save
map('n', '<leader>w', '<Cmd>set eventignore+=BufWritePre | w | set eventignore-=BufWritePre<CR>', opts)
