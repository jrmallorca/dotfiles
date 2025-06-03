local model = "deepseek-r1:1.5b"

require('gen').setup({
  model = model,
  display_mode = "split",
})

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader><leader>', ':CodeCompanionActions<CR>')
