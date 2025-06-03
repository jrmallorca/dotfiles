require("neotest").setup({
  adapters = {
    require('neotest-dart') {
      -- Command being used to run tests. Defaults to `flutter`
      -- Change it to `fvm flutter` if using FVM
      -- change it to `dart` for Dart only tests
      command = 'flutter',
      use_lsp = true -- When set Flutter outline information is used when constructing test name.
    },
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "dart", "vim", "lua" },
    }),
  },
})

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- [t         = Find previous failed test
-- ]t         = Find next failed test
-- <Leader>tt = Test everything
-- <Leader>tn = Test nearest to cursor
-- <Leader>to = Open output panel
local test = require('neotest')
map('n', '[t', function()
  test.jump.prev({ status = "failed" })
end, opts)
map('n', ']t', function()
  test.jump.next({ status = "failed" })
end, opts)
map('n', '<leader>tt', function()
  test.run.run(vim.fn.expand("%"))
  test.output_panel.open()
end, opts)
map('n', '<leader>tn', function()
  test.run.run()
  test.output_panel.open()
end, opts)
map('n', '<leader>to', function()
  test.output_panel.toggle()
end, opts)
