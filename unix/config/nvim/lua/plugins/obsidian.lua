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
  opts = {
    legacy_commands = false,
    ui = { enable = false },
    frontmatter = { enabled = false },
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
    templates = {
      folder = "templates/obsidian-nvim",
      date_format = "%Y-%m-%d",
      customizations = {
        task = { notes_subdir = "journal/tasks" },
        zettel = { notes_subdir = "zettelkasten/fleeting" },
        crm = { notes_subdir = "crm" },
        recipe = { notes_subdir = "recipes" },
      },
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
    picker = { name = "snacks.pick" },
    open_notes_in = "vsplit",
    callbacks = {
      enter_note = function(note)
        vim.keymap.set("n", "<CR>", require("obsidian").actions.smart_action, {
          desc = "Obsidian: Smart action",
        })
        vim.keymap.set("n", "<leader>ch", require("obsidian").actions.toggle_checkbox, {
          desc = "Obsidian: Toggle checkbox status",
        })
        vim.keymap.set("n", "d-", "<cmd>0;/#/;:s/-/ /g<CR>w~", {
          desc = "Obsidian: Format line with header 1",
        })
        vim.keymap.set("n", "<leader>rn", "<cmd>Obsidian rename<CR>", {
          desc = "Obsidian: Rename file",
        })
        vim.keymap.set("n", "<leader>f", "<cmd>Obsidian quick_switch<CR>", {
          desc = "Obsidian: Quick switch",
        })
        vim.keymap.set("n", "<leader>/", function()
          return Snacks.picker.grep({ cwd = Obsidian.dir.filename })
        end, {
          desc = "Obsidian: Find in files",
        })
        vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", {
          desc = "Obsidian: Find backlinks",
        })
        vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<CR>", {
          desc = "Obsidian: Find daily notes",
        })
        vim.keymap.set("n", "<leader>ot", "ggVGx<cmd>Obsidian template<CR>", {
          desc = "Obsidian: Replace template in file",
        })
      end,
    },
    attachments = { folder = "zettelkasten/attachments" },
  },
}
