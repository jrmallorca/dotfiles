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

-- TrueZen --
-- <Leader>zn = Narrow mode (Ataraxis on selected text)
-- <Leader>za = Ataraxis mode (Center text)
-- <Leader>zf = Focus mode (Focus on current buffer when split)
-- <Leader>zm = Minimalist mode (Turn off distractions)
local truezen = require('true-zen')
map('n', '<leader>zn', function()
  local first = 0
  local last = vim.api.nvim_buf_line_count(0)
  truezen.narrow(first, last)
end, opts)
map('v', '<leader>zn', function()
  local first = vim.fn.line('v')
  local last = vim.fn.line('.')
  truezen.narrow(first, last)
end, opts)
map('n', '<leader>zf', truezen.focus, opts)
map('n', '<leader>zm', truezen.minimalist, opts)
map('n', '<leader>za', truezen.ataraxis, opts)

-- Fuzzy finder --
-- <Leader>ff = Find files within current and child directories
-- <Leader>f/ = Find matching string within current and child directories
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, opts)
map('n', '<leader>f/', telescope.live_grep, opts)

-- Hop
-- f = Go to word
-- F = Go to line
local hop = require('hop')
map({ 'n', 'v' }, 'f', hop.hint_words, opts)
map({ 'n', 'v' }, 'F', hop.hint_lines_skip_whitespace, opts)

-- Neotest
-- ]t         = Find next failed test, direction up
-- [t         = Find next failed test, direction down
-- <Leader>tt = Test everything
-- <Leader>tn = Test nearest to cursor
local test = require('neotest')
-- map('n', ']t', [[<Plug>(ultest-next-fail)]], opts)
-- map('n', '[t', [[<Plug>(ultest-prev-fail)]], opts)
map('n', '<leader>tt', function()
  test.run.run()
end, opts)
map('n', '<leader>tn', function()
  test.run.run(vim.fn.expand("%"))
end, opts)

