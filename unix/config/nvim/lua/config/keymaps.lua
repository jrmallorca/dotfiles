-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- If it's a `<Plug>`, then DO NOT do `noremap = true`

-- Modes --
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)

-- Do not format on save
map("n", "<leader>w", "<Cmd>set eventignore+=BufWritePre | w | set eventignore-=BufWritePre<CR>", opts)
