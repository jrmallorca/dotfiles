local null_ls = require("null-ls")

-- code action sources
local code_actions = null_ls.builtins.code_actions

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

-- hover sources
local hover = null_ls.builtins.hover

-- Register any number of sources simultaneously
local sources = {
  -- Code actions
  code_actions.gitsigns,
  code_actions.proselint,

  -- Diagnostics
  diagnostics.checkmake,
  diagnostics.fish,
  diagnostics.yamllint,
  diagnostics.todo_comments,
  diagnostics.trail_space,

  -- Formatting
  formatting.astyle,
  formatting.shfmt,
  formatting.fish_indent,
  formatting.textlint,
  formatting.prettierd,

  -- Hover
  hover.printenv,
}

null_ls.setup({
  sources = sources,
})

require("mason-null-ls").setup({
  ensure_installed = {},
  automatic_installation = true,
  automatic_setup = false,
})
