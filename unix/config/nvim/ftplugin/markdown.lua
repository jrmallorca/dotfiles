-- Remap movement to be more friendly to text
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- https://github.com/renerocksai/telekasten.nvim/wiki/Commands
local telekasten = require('telekasten')
map('n', '<leader>z', telekasten.panel, opts)
map('n', '<leader>zf', telekasten.find_notes, opts)
map('n', '<leader>zF', telekasten.find_friends, opts)
map('n', '<leader>zD', telekasten.find_daily_notes, opts)
map('n', '<leader>z/', telekasten.search_notes, opts)
map('n', '<leader>zd', telekasten.goto_today, opts)
map('n', '<leader>zl', telekasten.follow_link, opts)
map('n', '<leader>z[', telekasten.insert_link, opts)
map('n', '<leader>zn', telekasten.new_note, opts)
map('n', '<leader>zN', telekasten.new_templated_note, opts)
map('n', '<leader>zb', telekasten.show_backlinks, opts)

map('n', '<leader>zM',
  function()
    if (vim.bo.filetype == "telekasten") then
      vim.bo.filetype = "markdown"
    else
      vim.bo.filetype = "telekasten"
    end
  end,
  opts
)

map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', '$', 'g$', opts)
map('n', '0', 'g0', opts)
map('n', '<Down>', 'g<Down>', opts)
map('n', '<Up>', 'g<Up>', opts)

vim.wo.wrap = true -- Wrap lines
vim.wo.linebreak = true -- Text will not break in the middle of a word when wrapping
vim.wo.spell = true -- Indicate spelling errors
