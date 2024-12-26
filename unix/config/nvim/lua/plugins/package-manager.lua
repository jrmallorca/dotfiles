local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local api = vim.api
local grp = api.nvim_create_augroup("package_manager_user_config", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  pattern = "package-manager.lua",
  command = "Lazy sync",
  group = grp,
})

local opts = {
  ui = {
    backdrop = 100,
  }
}

local plugins = {
  -- Requirements
  'folke/lazy.nvim',                 -- Package manager
  'nvim-lua/plenary.nvim',           -- (Required for many plugins) Neovim functions helper
  'antoinemadec/FixCursorHold.nvim', -- (Required for neotest) Fix cursor hold autocmd events
  'nvim-neotest/nvim-nio',

  -- UI
  'Pocco81/TrueZen.nvim',       -- Better UI
  'junegunn/limelight.vim',     -- Dim surrounding text
  'lewis6991/gitsigns.nvim',    -- Display git signs
  {
    'ellisonleao/gruvbox.nvim', -- Gruvbox theme
    lazy = false,               -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,            -- make sure to load this before all the other start plugins
  },

  -- Functionality
  {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder
    tag = '0.1.4',
  },
  'tpope/vim-eunuch', -- Allow UNIX shell commands in Neovim

  -- IDE functionality
  -- Setup explanation:
  --    - mason installs packages
  --    - mason-lspconfig installs LSPs only
  --    - nvim-lspconfig integrates the LSPs into Neovim
  --    - null-ls integrates the packages into Neovim
  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code using a fast incremental parsing library
    cmd = 'TSUpdate',
  },
  {
    'williamboman/mason.nvim',           -- Package manager of language servers, DAP servers, linters and formatters
    'neovim/nvim-lspconfig',             -- Configurations for built-in LSP client
    'williamboman/mason-lspconfig.nvim', -- Language server installer for mason
    'nvimtools/none-ls.nvim',            -- Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    'jayp0521/mason-null-ls.nvim',       -- Linter and formatter installer for mason
    'mfussenegger/nvim-dap',             -- Debugger for Neovim
    'jayp0521/mason-nvim-dap.nvim',      -- Debug adapter installer for mason
  },
  'hrsh7th/cmp-nvim-lsp',                -- Make Neovim use cmp for LSP
  'hrsh7th/nvim-cmp',                    -- Autocompletion plugin
  'L3MON4D3/LuaSnip',                    -- Snippets engine
  'saadparwaiz1/cmp_luasnip',            -- Use snippets engine in autocompletion plugin
  'rafamadriz/friendly-snippets',        -- Pre-existing VSCode snippets
  'nvim-neotest/neotest',                -- Testing
  'sidlatau/neotest-dart',               -- Dart Testing
  'nvim-neotest/neotest-plenary',        -- Neotest adapter for Plenary
  'nvim-neotest/neotest-vim-test',       -- Neotest adapter for vim-test
  {                                      -- Flutter tools and Dart LSP setup
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  },

  -- Useful bindings
  'windwp/nvim-autopairs',      -- Autopairs plugin
  {
    'phaazon/hop.nvim',         -- Navigation
    branch = 'v2',              -- optional but strongly recommended
  },
  'winston0410/commented.nvim', -- Comment blocks of code

  -- Zettelkasten
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "Documents/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "Documents/*.md",
    },
  }
}

require("lazy").setup(plugins, opts)
