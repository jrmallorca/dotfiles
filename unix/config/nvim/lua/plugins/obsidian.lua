local obsidian = require('obsidian')
local telescope = require('telescope.builtin')

obsidian.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/Documents",
    },
  },

  templates = {
    folder = "templates/obsidian-nvim",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {
      -- https://otland.net/threads/lua-get-day-of-next-week.165801/
      nextSunday = function()
        for i = 1, 7 do
          if os.date('%A', os.time() + 24 * 3600 * i) == "Sunday" then
            return os.date('%Y-%m-%d', os.time() + 24 * 3600 * i)
          end
        end
      end,
      currentYear = function()
        return os.date('%Y')
      end
    },
  },

  daily_notes = {
    folder = "journal/daily",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    default_tags = {},
    template = "daily.md"
  },

  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return obsidian.util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return obsidian.util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<cr>"] = {
      action = function()
        return obsidian.util.smart_action()
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
    ["<leader>f/"] = {
      action = function()
        return telescope.live_grep({ cwd = obsidian.get_client().dir.filename })
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

  -- Optional, customize how wiki links are formatted. You can set this to one of:
  --  * "use_alias_only", e.g. '[[Foo Bar]]'
  --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
  --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
  --  * "use_path_only", e.g. '[[foo-bar.md]]'
  -- Or you can set it to a function that takes a table of options and returns a string, like this:
  wiki_link_func = function(opts)
    return require("obsidian.util").wiki_link_id_prefix(opts)
  end,

  -- Optional, alternatively you can customize the frontmatter data.
  ---@return table
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

  follow_url_func = function(url)
    vim.ui.open(url)
  end,

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
  -- file it will be ignored but you can customize this behavior here.
  ---@param img string
  follow_img_func = function(img)
    --  vim.fn.jobstart { "qlmanage", "-p", img }  -- Mac OS quick look preview
    vim.fn.jobstart({ "xdg-open", img }) -- linux
    -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
  end,

  picker = {
    name = "telescope.nvim",
    note_mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
    tag_mappings = {
      -- Add tag(s) to current note.
      tag_note = "<C-x>",
      -- Insert a tag at the current location.
      insert_tag = "<C-l>",
    },
  },

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "vsplit",

  -- Specify how to handle attachments.
  attachments = {
    -- The default folder to place images in via `:ObsidianPasteImg`.
    -- If this is a relative path it will be interpreted as relative to the vault root.
    -- You can always override this per image by passing a full path to the command instead of just a filename.
    img_folder = "zettelkasten/attachments",

    -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
    ---@return string
    img_name_func = function()
      -- Prefix image names with timestamp.
      return string.format("%s-", os.time())
    end,

    -- A function that determines the text to insert in the note when pasting an image.
    -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
    -- This is the default implementation.
    ---@param client obsidian.Client
    ---@param path obsidian.Path the absolute path to the image file
    ---@return string
    img_text_func = function(client, path)
      path = client:vault_relative_path(path) or path
      return string.format("![%s](%s)", path.name, path)
    end,
  },
})
