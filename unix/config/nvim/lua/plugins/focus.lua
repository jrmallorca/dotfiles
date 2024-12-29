local map = vim.keymap.set
local focus = require('focus')

focus.setup({
  on_open = function(_)
    local opts = { noremap = true, silent = true }

    -- Hack to quit neovim from focus mode
    -- https://github.com/folke/zen-mode.nvim/issues/54#issuecomment-1200155414
    map('n', 'ZQ', function()
      vim.cmd("let b:quitting = 1")
      vim.cmd("q!")
    end, opts)
    map('n', 'ZZ', function()
      vim.cmd("let b:quitting = 1")
      vim.cmd("x")
    end, opts)
    vim.cmd("cabbrev <buffer> q let b:quitting = 1 <bar> q")
    vim.cmd("cabbrev <buffer> wq let b:quitting = 1 <bar> wq")
  end,
  on_close = function()
    if vim.b.quitting == 1 then
      vim.b.quitting = 0
      vim.cmd("q")
    end
  end,
})

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- <Leader>vn = Narrow mode
-- <Leader>vf = Focus mode (Focus on current buffer when split)
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
