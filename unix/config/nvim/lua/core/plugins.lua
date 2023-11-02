-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print("Installing packer, please close and reopen Neovim...")
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local is_bootstrapped = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local api = vim.api
local grp = api.nvim_create_augroup("packer_user_config", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
  group = grp,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end
  }
})

-- Install your plugins here
return require('packer').startup(function(use)
  -- Requirements
  use 'wbthomason/packer.nvim'          -- Package manager
  use "nvim-lua/plenary.nvim"           -- (Required for many plugins) Neovim functions helper
  use 'antoinemadec/FixCursorHold.nvim' -- (Required for neotest) Fix cursor hold autocmd events

  -- UI
  use 'Pocco81/TrueZen.nvim'    -- Better UI
  use 'junegunn/limelight.vim'  -- Dim surrounding text
  use 'lewis6991/gitsigns.nvim' -- Display git signs

  -- Functionality
  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder
    tag = '0.1.4',
  }
  use 'tpope/vim-eunuch' -- Allow UNIX shell commands in Neovim

  -- IDE functionality
  -- Setup explanation:
  --    - mason installs packages
  --    - mason-lspconfig installs LSPs only
  --    - nvim-lspconfig integrates the LSPs into Neovim
  --    - null-ls integrates the packages into Neovim
  use {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code using a fast incremental parsing library
    run = ':TSUpdate',
  }
  use {
    'williamboman/mason.nvim',           -- Package manager of language servers, DAP servers, linters and formatters
    'neovim/nvim-lspconfig',             -- Configurations for built-in LSP client
    'williamboman/mason-lspconfig.nvim', -- Language server installer for mason
    'nvimtools/none-ls.nvim',            -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    'jayp0521/mason-null-ls.nvim',       -- Linter and formatter installer for mason
    'mfussenegger/nvim-dap',             -- Debugger for Neovim
    'jayp0521/mason-nvim-dap.nvim',      -- Debug adapter installer for mason
  }
  use 'hrsh7th/cmp-nvim-lsp'             -- Make Neovim use cmp for LSP
  use 'hrsh7th/nvim-cmp'                 -- Autocompletion plugin
  use 'L3MON4D3/LuaSnip'                 -- Snippets engine
  use 'saadparwaiz1/cmp_luasnip'         -- Use snippets engine in autocompletion plugin
  use 'rafamadriz/friendly-snippets'     -- Pre-existing VSCode snippets
  use 'nvim-neotest/neotest'             -- Testing
  use 'sidlatau/neotest-dart'            -- Dart Testing
  use 'nvim-neotest/neotest-plenary'     -- Neotest adapter for Plenary
  use 'nvim-neotest/neotest-vim-test'    -- Neotest adapter for vim-test
  use {                                  -- Flutter tools and Dart LSP setup
    'akinsho/flutter-tools.nvim',
    requires = {
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }

  -- Useful bindings
  use 'windwp/nvim-autopairs'      -- Autopairs plugin
  use {
    'phaazon/hop.nvim',            -- Navigation
    branch = 'v2',                 -- optional but strongly recommended
  }
  use 'winston0410/commented.nvim' -- Comment blocks of code

  -- Zettelkasten
  use 'renerocksai/telekasten.nvim' -- Zettelkasten functionally for markdown vaults

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if is_bootstrapped then require("packer").sync() end
end)
