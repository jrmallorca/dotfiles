local opt = vim.opt
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local g = vim.g

opt.shell = "/bin/bash" -- Use bash for scripts

wo.statusline = "%F"

-- Hide buffer when abandoned instead of closing
-- Do not save when switching buffers
o.hidden = true

o.updatetime = 250          -- Decrease update time

wo.relativenumber = true    -- Show relative line numbers
wo.number = true            -- Show actual line numbers (where the cursor is)
wo.signcolumn = 'yes'       -- Display sign column

o.pastetoggle = "<F2>"      -- Toggle paste format via 'F2'
o.clipboard = "unnamedplus" -- Yank to system clipboard

o.expandtab = true          -- Tabs become spaces
bo.expandtab = true
o.tabstop = 4               -- Tabs becomes 4 space width
bo.tabstop = 4
o.shiftwidth = 4            -- Indenting with '>' uses 4 space width
bo.shiftwidth = 4

wo.wrap = false       -- Don't wrap lines
wo.breakindent = true -- Preserve indentation within wrapped lines
o.autoindent = true   -- Copy indent from current line when starting new line
bo.autoindent = true
o.smartindent = true  -- Smart auto indentation
bo.smartindent = true

o.spelllang = "en_gb"

-- Case insensitive searching unless /C or capital in search
o.ignorecase = true
o.smartcase = true

o.hlsearch = false                 -- Don't highlight what has been searched
o.incsearch = true                 -- Incrementally highlight what is currently being searched

o.splitright = true                -- New horizontal window is positioned to the right of current window
o.splitbelow = true                -- New vertical window is positioned below current window

o.inccommand = "nosplit"           -- Show effects of a command incrementally

vim.cmd [[set undofile]]           -- Save undo history

o.completeopt = 'menuone,noinsert' -- Completion

-- in millisecond, used for both CursorHold and CursorHoldI,
-- use updatetime instead if not defined
g.cursorhold_updatetime = 100
