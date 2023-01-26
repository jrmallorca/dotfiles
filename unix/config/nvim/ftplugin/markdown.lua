-- Remap movement to be more friendly to text
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '$', 'g$', opts)
map('n', '0', 'g0', opts)
map('n', '<Down>', 'g<Down>', opts)
map('n', '<Up>', 'g<Up>', opts)

vim.wo.wrap = true -- Wrap lines
vim.wo.linebreak = true -- Text will not break in the middle of a word when wrapping
vim.wo.spell = true -- Indicate spelling errors
