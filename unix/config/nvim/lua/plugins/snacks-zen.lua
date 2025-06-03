return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      zen = {
        toggles = {
          git_signs = true,
          mini_diff_signs = true,
        },
        on_open = function(_)
          local map = vim.keymap.set
          local opts = { noremap = true, silent = true }

          -- Hack to quit neovim from focus mode
          -- https://github.com/folke/zen-mode.nvim/issues/54#issuecomment-1200155414
          map("n", "ZQ", function()
            vim.cmd("let b:quitting = 1")
            vim.cmd("q!")
          end, opts)
          map("n", "ZZ", function()
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
      },
    },
  },
}
