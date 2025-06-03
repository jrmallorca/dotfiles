local plugin = require('twilight')
plugin.setup()

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map('n', '<leader>ll', plugin.toggle, opts)
