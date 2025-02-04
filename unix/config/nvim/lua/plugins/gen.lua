require('gen').setup({
  model = "deepseek-r1:1.5b",
  display_mode = "split",
})

vim.keymap.set({ 'n', 'v' }, '<leader><leader>', ':Gen<CR>')
