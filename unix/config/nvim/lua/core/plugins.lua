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
  use 'wbthomason/packer.nvim' -- Package manager
  use 'lewis6991/impatient.nvim' -- Reduce Neovim startup time
  use 'antoinemadec/FixCursorHold.nvim' -- Fix cursor hold autocmd events
  use 'Pocco81/TrueZen.nvim' -- Better UI
  use 'junegunn/limelight.vim' -- Dim surrounding text
  use { -- Display git signs
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use { -- Fuzzy finder
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { -- Highlight, edit, and navigate code using a fast incremental parsing library
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use {
      "williamboman/mason.nvim", -- Package manager of LSP servers, DAP servers, linters and formatters
      "williamboman/mason-lspconfig.nvim", -- Server installer for LSP
      "neovim/nvim-lspconfig", -- Configurations for built-in LSP client
  }
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- Make Neovim use cmp for LSP
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use "rafamadriz/friendly-snippets" -- Pre-existing VSCode snippets
  use 'windwp/nvim-autopairs' -- Autopairs plugin
  use { -- Navigation
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  }
  use 'winston0410/commented.nvim' -- Comment blocks of code
  use { -- Testing
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require("packer").sync() end
end)
