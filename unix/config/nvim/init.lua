-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- When entering Neovim, turn on Zen mode from Snacks.nvim
-- https://github.com/folke/zen-mode.nvim/issues/98
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "*" },
  callback = Snacks.zen.zen,
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
  pattern = { "*" },
  callback = Snacks.zen.zen,
})
