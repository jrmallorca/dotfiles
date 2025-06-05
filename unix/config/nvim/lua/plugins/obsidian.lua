return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents",
      },
    },

    daily_notes = {
      folder = "journal/daily",
      default_tags = {},
      template = "daily.md",
      -- workdays_only = true,
    },

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      ["d-"] = { -- Find the title, replace the dashes with space, and capitalise the first letter.
        action = "<cmd>0;/#/;:s/-/ /g<CR>w~",
        opts = { noremap = true, silent = true },
      },
      ["<leader>rn"] = {
        action = "<cmd>ObsidianRename<CR>",
        opts = { noremap = true, silent = true },
      },
      ["<leader>ff"] = {
        action = "<cmd>ObsidianQuickSwitch<CR>",
        opts = { noremap = true, silent = true },
      },
      ["<leader>/"] = {
        action = function()
          return Snacks.picker.grep({ cwd = require("obsidian").get_client().dir.filename })
        end,
        opts = { noremap = true, silent = true },
      },
      ["<leader>ob"] = {
        action = "<cmd>ObsidianBacklinks<CR>",
        opts = { noremap = true, silent = true },
      },
      ["<leader>od"] = {
        action = "<cmd>ObsidianDailies<CR>",
        opts = { noremap = true, silent = true },
      },
      ["<leader>ox"] = {
        action = "<cmd>ObsidianExtractNote<CR>",
        opts = { noremap = true, silent = true },
      },
      ["<leader>ot"] = {
        action = "ggVGx<cmd>ObsidianTemplate<CR>",
        opts = { noremap = true, silent = true },
      },
      ["<leader>or"] = {
        action = "<cmd>ObsidianRename<CR>",
        opts = { noremap = true, silent = true },
      },
    },

    new_notes_location = "current_dir",

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,

    note_frontmatter_func = function(note)
      local out = {
        tags = note.tags,
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      out["modified_on"] = os.date("%Y-%m-%d %H:%M:%S", os.time())

      return out
    end,

    templates = {
      folder = "templates/obsidian-nvim",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        -- https://otland.net/threads/lua-get-day-of-next-week.165801/
        nextSunday = function()
          for i = 1, 7 do
            if os.date("%A", os.time() + 24 * 3600 * i) == "Sunday" then
              return os.date("%Y-%m-%d", os.time() + 24 * 3600 * i)
            end
          end
        end,
        currentYear = function()
          return os.date("%Y")
        end,
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
        tomorrow = function()
          return os.date("%Y-%m-%d", os.time() + 86400)
        end,
      },
    },

    picker = {
      name = "snacks.pick",
    },

    open_notes_in = "vsplit",

    -- Optional, define your own callbacks to further customize behavior.
    callbacks = {
      -- Runs at the end of `require("obsidian").setup()`.
      ---@param client obsidian.Client
      post_setup = function(client) end,

      -- Runs anytime you enter the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      enter_note = function(client, note) end,

      -- Runs anytime you leave the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      leave_note = function(client, note) end,

      -- Runs right before writing the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      pre_write_note = function(client, note) end,

      -- Runs anytime the workspace is set/changed.
      ---@param client obsidian.Client
      ---@param workspace obsidian.Workspace
      post_set_workspace = function(client, workspace) end,
    },

    attachments = {
      img_folder = "zettelkasten/attachments",
    },

    statusline = {
      enabled = true,
      format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
    },
  },
}
