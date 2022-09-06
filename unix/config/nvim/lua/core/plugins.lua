local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    print("Installing packer, please close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({border = "rounded"})
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
  use {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code using a fast incremental parsing library
    run = ':TSUpdate',
  }
  use {
    'williamboman/mason.nvim', -- Package manager of LSP servers, DAP servers, linters and formatters
    'williamboman/mason-lspconfig.nvim', -- Server installer for LSP
    'neovim/nvim-lspconfig', -- Configurations for built-in LSP client
  }
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- Make Neovim use cmp for LSP
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use "rafamadriz/friendly-snippets" -- Pre-existing VSCode snippets
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
