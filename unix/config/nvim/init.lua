vim.loader.enable()

for _, source in ipairs({
  -- CORE
  "core.maps",
  "core.opts",
  "core.cmds",

  -- PLUGINS
  "plugins.package-manager",
  "plugins.gruvbox",
  "plugins.telescope",
  "plugins.gitsigns",
  "plugins.focus",
  "plugins.mason",
  "plugins.null-ls",
  "plugins.lspconfig",
  "plugins.nvim-cmp",
  "plugins.nvim-autopairs",
  "plugins.neotest",
  "plugins.nvim-dap",
  "plugins.commented",
  "plugins.nvim-treesitter",
  "plugins.hop",
  "plugins.obsidian",
  "plugins.flutter-tools",

  -- Make colours come after everything, especially the theme (currently gruvbox)
  "core.colors",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end
