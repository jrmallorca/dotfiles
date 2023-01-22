-- Key mappings
local telekasten = require('telekasten')
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- https://github.com/renerocksai/telekasten.nvim/wiki/Commands
map('n', '<leader>f', telekasten.panel, opts)
map('n', '<leader>ff', telekasten.find_notes, opts)
map('n', '<leader>fd', telekasten.find_daily_notes, opts)
map('n', '<leader>f/', telekasten.search_notes, opts)
map('n', '<leader>fl', telekasten.follow_link, opts)
map('n', '<leader>fi', telekasten.insert_link, opts)
map('n', '<leader>fnn', telekasten.new_note, opts)
map('n', '<leader>fnt', telekasten.new_templated_note, opts)

-- Remap movement to be more friendly to text
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '<Down>', 'g<Down>', opts)
map('n', '<Up>', 'g<Up>', opts)

vim.opt_local.filetype = "markdown"
vim.wo.wrap = true -- Wrap lines
vim.wo.linebreak = true -- Text will not break in the middle of a word when wrapping
vim.wo.spell = true -- Indicate spelling errors
