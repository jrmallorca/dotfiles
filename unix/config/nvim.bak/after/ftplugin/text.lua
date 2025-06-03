local bo = vim.bo
local wo = vim.wo

-- Remap movement to be more friendly to text
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '$', 'g$', opts)
map('n', '0', 'g0', opts)
map('n', '<Down>', 'g<Down>', opts)
map('n', '<Up>', 'g<Up>', opts)

wo.wrap = true      -- Wrap lines
wo.linebreak = true -- Text will not break in the middle of a word when wrapping
wo.spell = true     -- Indicate spelling errors
bo.tabstop = 2      -- Tabs becomes 2 space width
bo.shiftwidth = 2   -- Indenting with '>' uses 2 space width
