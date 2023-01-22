require('hop').setup {
  keys = 'tnseriaodhc,gmvkxzplfuwybjq',
}

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- f = Go to word
-- F = Go to line
local hop = require('hop')
map({ 'n', 'v' }, 'f', hop.hint_words, opts)
map({ 'n', 'v' }, 'F', hop.hint_lines_skip_whitespace, opts)
