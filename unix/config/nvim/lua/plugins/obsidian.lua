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
    ui = { enable = false },

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
      enter_note = function(client, note)
        vim.keymap.set("n", "<CR>", function()
          return require("obsidian").util.smart_action()
        end, {
          desc = "Obsidian: Smart action",
        })
        vim.keymap.set("n", "<leader>ch", function()
          return require("obsidian").util.toggle_checkbox()
        end, {
          desc = "Obsidian: Toggle checkbox status",
        })
        vim.keymap.set("n", "d-", "<cmd>0;/#/;:s/-/ /g<CR>w~", {
          desc = "Obsidian: Format line with header 1",
        })
        vim.keymap.set("n", "<leader>rn", "<cmd>ObsidianRename<CR>", {
          desc = "Obsidian: Rename file",
        })
        vim.keymap.set("n", "<leader>f", "<cmd>ObsidianQuickSwitch<CR>", {
          desc = "Obsidian: Quick switch",
        })
        vim.keymap.set("n", "<leader>/", function()
          return Snacks.picker.grep({ cwd = require("obsidian").get_client().dir.filename })
        end, {
          desc = "Obsidian: Find in files",
        })
        vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", {
          desc = "Obsidian: Find backlinks",
        })
        vim.keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<CR>", {
          desc = "Obsidian: Find daily notes",
        })
        vim.keymap.set("n", "<leader>ot", "ggVGx<cmd>ObsidianTemplate<CR>", {
          desc = "Obsidian: Replace template in file",
        })
      end,

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
