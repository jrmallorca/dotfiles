local focus = require('focus')

focus.setup({
  auto_zen = false,
  zen = {
    opts = {
      -- cmdheight = 0,          -- disable cmdline
      -- cursorline = false,     -- disable cursorline
      -- laststatus = 0,         -- disable statusline
      -- number = false,         -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- foldcolumn = "0",       -- disable fold column
      signcolumn = "yes",
      -- statuscolumn = " ",     -- disable status column
    },
    diagnostics = false, -- disables diagnostics
  },
})

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- <Leader>vn = Narrow mode
-- <Leader>vf = Focus mode (Focus on current buffer when split)
-- <Leader>vz = Zen mode (Remove distractions)
map('n', '<leader>vn', function()
  local first = 0
  local last = vim.api.nvim_buf_line_count(0)
  focus.toggle_narrow({ line1 = first, line2 = last })
end, opts)
map('v', '<leader>vn', function()
  local first = vim.fn.line('v')
  local last = vim.fn.line('.')
  focus.toggle_narrow({ line1 = first, line2 = last })
end, opts)
map('n', '<leader>vf', '<cmd>:Focus<cr>', opts)
map('n', '<leader>vz', focus.toggle_zen, opts)
