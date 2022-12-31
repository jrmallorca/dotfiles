local null_ls = require("null-ls")

-- code action sources
local code_actions = null_ls.builtins.code_actions

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

-- hover sources
local hover = null_ls.builtins.hover

-- completion sources
local completion = null_ls.builtins.completion

-- Register any number of sources simultaneously
local sources = {
  -- Code actions
  code_actions.gitsigns,
  code_actions.proselint,
  code_actions.refactoring,
  code_actions.shellcheck,

  -- Completion
  completion.luasnip,
  completion.spell,

  -- Diagnostics
  diagnostics.alex,
  diagnostics.checkmake,
  diagnostics.codespell,
  diagnostics.commitlint,
  -- diagnostics.eslint_d,
  diagnostics.fish,
  diagnostics.markdownlint,
  diagnostics.proselint,
  diagnostics.shellcheck,
  diagnostics.yamllint,
  diagnostics.jsonlint,
  diagnostics.todo_comments,
  diagnostics.trail_space,

  -- Formatting
  -- formatting.astyle,
  formatting.beautysh,
  formatting.codespell,
  -- formatting.csharpier,
  -- formatting.dart_format,
  formatting.eslint_d,
  formatting.fish_indent,
  formatting.prettierd,
  formatting.trim_newlines,
  formatting.trim_whitespace,
  formatting.trim_whitespace,

  -- Hover
  hover.printenv,
}

null_ls.setup({ sources = sources })

require("mason-null-ls").setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
})
