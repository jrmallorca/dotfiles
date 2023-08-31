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

  -- Completion
  completion.spell,

  -- Diagnostics
  diagnostics.checkmake,
  diagnostics.commitlint,
  diagnostics.fish,
  diagnostics.yamllint,
  diagnostics.jsonlint,
  diagnostics.todo_comments,
  diagnostics.trail_space,
  diagnostics.semgrep,

  -- Formatting
  formatting.astyle,
  formatting.shfmt,
  -- formatting.csharpier,
  -- formatting.dart_format,
  formatting.fish_indent,
  formatting.deno_fmt.with({
    extra_args = function(params)
      return params.options
          and {
            "--options-line-width",
            99999,
          }
    end,
  }),
  formatting.textlint,
  formatting.trim_newlines,
  formatting.trim_whitespace,

  -- Hover
  hover.printenv,
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

null_ls.setup({
  sources = sources,
  on_attach = on_attach
})

require("mason-null-ls").setup({
  ensure_installed = {},
  automatic_installation = true,
  automatic_setup = false,
})
