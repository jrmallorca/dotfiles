-- If it's a `<Plug>`, then DO NOT do `noremap = true`

-- Modes --
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Remap space as leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- TrueZen --
-- <Leader>zn = Narrow mode (Ataraxis on selected text)
-- <Leader>za = Ataraxis mode (Center text)
-- <Leader>zf = Focus mode (Focus on current buffer when split)
-- <Leader>zm = Minimalist mode (Turn off distractions)
map("n", "<leader>zn", ":TZNarrow<CR>", {})
map("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
map("n", "<leader>zf", ":TZFocus<CR>", {})
map("n", "<leader>zm", ":TZMinimalist<CR>", {})
map("n", "<leader>za", ":TZAtaraxis<CR>", {})

-- Fuzzy finder --
-- \\  = Find files within current and child directories
-- \/  = Find matching string within current and child directories
map('n', '<leader>ff', [[<Cmd>Telescope find_files<CR>]], opts)
map('n', '<leader>f/', [[<Cmd>Telescope live_grep<CR>]], opts)

-- Hop
-- Replace 's' with 'f'
map("n" , "f", ":HopWord<CR>", opts)
map("n" , "F", ":HopLineStart<CR>", opts)

-- Ultest
-- ]t         = Find next failed test, direction up
-- [t         = Find next failed test, direction down
-- <Leader>tt = Test everything
-- <Leader>tn = Test nearest to cursor
map('n', ']t', [[<Plug>(ultest-next-fail)]], { silent = true })
map('n', '[t', [[<Plug>(ultest-prev-fail)]], { silent = true })
map('n', '<Leader>tt', [[<Plug>(ultest-run-file)]], { silent = true })
map('n', '<Leader>tn', [[<Plug>(ultest-run-nearest)]], { silent = true })
