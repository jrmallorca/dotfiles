-- Override flash.nvim config that is already present in LazyVim.
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    labels = 'tnseriaodhc,gmvkxzplfuwybjq',
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = false,
      }
    }
  }
}
