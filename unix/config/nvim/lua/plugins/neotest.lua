require("neotest").setup({
  adapters = {
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ]t         = Find next failed test, direction up
-- [t         = Find next failed test, direction down
-- <Leader>tt = Test everything
-- <Leader>tn = Test nearest to cursor
local test = require('neotest')
-- map('n', ']t', [[<Plug>(ultest-next-fail)]], opts)
-- map('n', '[t', [[<Plug>(ultest-prev-fail)]], opts)
map('n', '<leader>tt', function()
  test.run.run()
end, opts)
map('n', '<leader>tn', function()
  test.run.run(vim.fn.expand("%"))
end, opts)
