-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer, please close and reopen Neovim...")
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

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
  use 'wbthomason/packer.nvim' -- Package manager
  use 'lewis6991/impatient.nvim' -- Reduce Neovim startup time
  use "nvim-lua/plenary.nvim" -- (Required for many plugins) Neovim functions helper
  use 'antoinemadec/FixCursorHold.nvim' -- (Required for neotest) Fix cursor hold autocmd events

  -- UI
  use 'Pocco81/TrueZen.nvim' -- Better UI
  use 'junegunn/limelight.vim' -- Dim surrounding text
  use 'lewis6991/gitsigns.nvim' -- Display git signs
  use { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
  }

  -- Functionality
  use { -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
  }
  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder
    tag = '0.1.0',
  }

  -- IDE functionality
  -- Setup explanation:
  --    - mason installs the packages
  --    - null-ls integrates the packages into Neovim
  use {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code using a fast incremental parsing library
    run = ':TSUpdate',
  }
  use {
    'williamboman/mason.nvim', -- Package manager of language servers, DAP servers, linters and formatters
    'williamboman/mason-lspconfig.nvim', -- Language server installer for mason
    'neovim/nvim-lspconfig', -- Configurations for built-in LSP client
  }
  use 'hrsh7th/cmp-nvim-lsp' -- Make Neovim use cmp for LSP
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  -- use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'L3MON4D3/LuaSnip' -- Snippets engine
  use 'rafamadriz/friendly-snippets' -- Pre-existing VSCode snippets
  use 'nvim-neotest/neotest' -- Testing

  -- Useful bindings
  use 'windwp/nvim-autopairs' -- Autopairs plugin
  use {
    'phaazon/hop.nvim', -- Navigation
    branch = 'v2', -- optional but strongly recommended
  }
  use 'winston0410/commented.nvim' -- Comment blocks of code

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require("packer").sync() end
end)
