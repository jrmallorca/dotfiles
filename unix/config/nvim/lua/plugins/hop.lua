local hop = require('hop')

hop.setup {
  keys = 'tnseriaodhc,gmvkxzplfuwybjq',
  multi_windows = true,
}

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- f = Go to word
-- F = Go to line
map({ 'n', 'v' }, 'f', hop.hint_words, opts)
map({ 'n', 'v' }, 'F', function()
  hop.hint_char1({
    current_line_only = true
  })
end, opts)
