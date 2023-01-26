-- NOTE for Windows users:
-- - don't use Windows
-- - try WSL2 on Windows and pretend you're on Linux
-- - if you **must** use Windows, use "/Users/myname/zettelkasten" instead of "~/zettelkasten"
-- - NEVER use "C:\Users\myname" style paths
-- - Using `vim.fn.expand("~/zettelkasten")` should work now but mileage will vary with anything outside of finding and opening files

local home = vim.fn.expand("~/Documents/work-vault")
local templates_dir = 'templates/telekasten'

require('telekasten').setup({
  home = home,

  -- dir names for special notes (absolute path or subdir name)
  dailies   = home .. '/' .. 'journal/daily',
  weeklies  = home .. '/' .. 'journal/weekly',
  templates = home .. '/' .. templates_dir,

  -- image (sub)dir for pasting
  -- dir name (absolute path or subdir name)
  -- or nil if pasted images shouldn't go into a special subdir
  image_subdir = "attachments",

  -- if not nil, this string replaces spaces in the title when generating filenames
  filename_space_subst = '-',

  -- following a link to a non-existing note will create it
  follow_creates_nonexisting = true,
  dailies_create_nonexisting = true,
  weeklies_create_nonexisting = false,

  -- skip telescope prompt for goto_today and goto_thisweek
  journal_auto_open = true,

  -- template for new notes (new_note, follow_link)
  -- set to `nil` or do not specify if you do not want a template
  template_new_note = home .. '/' .. templates_dir .. '/' .. 'zettel.md',

  -- template for newly created daily notes (goto_today)
  -- set to `nil` or do not specify if you do not want a template
  template_new_daily = home .. '/' .. templates_dir .. '/' .. 'daily.md',

  -- image link style
  -- wiki:     ![[image name]]
  -- markdown: ![](image_subdir/xxxxx.png)
  image_link_style = "wiki",

  -- default sort option: 'filename', 'modified'
  sort = "modified",

  -- telescope actions behavior
  close_after_yanking = false,
  insert_after_inserting = true,

  -- tag notation: '#tag', ':tag:', 'yaml-bare'
  tag_notation = "yaml-bare",

  -- when linking to a note in subdir/, create a [[subdir/title]] link
  -- instead of a [[title only]] link
  subdirs_in_links = false,

  -- template_handling
  -- What to do when creating a new note via `new_note()` or `follow_link()`
  -- to a non-existing note
  -- - prefer_new_note: use `new_note` template
  -- - smart: if day or week is detected in title, use daily / weekly templates (default)
  -- - always_ask: always ask before creating a note
  template_handling = "always_ask",
})
