-- Key mappings
local telekasten = require('telekasten')
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- https://github.com/renerocksai/telekasten.nvim/wiki/Commands
map('n', '<leader>z', telekasten.panel, opts)
map('n', '<leader>zf', telekasten.find_notes, opts)
map('n', '<leader>zd', telekasten.find_daily_notes, opts)
map('n', '<leader>zg', telekasten.search_notes, opts)
map('n', '<leader>zz', telekasten.follow_link, opts)
map('n', '<leader>znn', telekasten.new_note, opts)
map('n', '<leader>znt', telekasten.new_templated_note, opts)

-- Remap movement to be more friendly to text
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '<Down>', 'g<Down>', opts)
map('n', '<Up>', 'g<Up>', opts)

vim.wo.wrap = true -- Wrap lines
vim.wo.linebreak = true -- Text will not break in the middle of a word when wrapping
vim.wo.spell = true -- Indicate spelling errors
