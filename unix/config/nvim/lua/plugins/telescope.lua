local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false
      },
    },
    buffer_previewer_maker = new_maker,
  }
}

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- <Leader>ff = Find files within current and child directories
-- <Leader>f/ = Find matching string within current and child directories
-- <Leader>mv = Move file to new directory
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, opts)
map('n', '<leader>f/', telescope.live_grep, opts)

local root_patterns = { ".git", ".obsidian" }
map("n", "<leader>mv", function()
  local current_file = vim.fn.expand("%:p")
  local current_file_name = vim.fn.fnamemodify(current_file, ":t")

  telescope.find_files({
    prompt_title = "Select Folder to Move File",
    cwd = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1]),
    find_command = { "fd", ".", "--type", "directory", "--exclude", "./.git/*" }, -- Use find to get directories
    attach_mappings = function(prompt_bufnr, mapping)
      mapping("i", "<CR>", function()
        local new_dir = require("telescope.actions.state").get_selected_entry().path
        require("telescope.actions").close(prompt_bufnr)

        -- Ask for confirmation/edit of new filename
        vim.ui.input({ prompt = "New filename: ", default = current_file_name }, function(new_file_name)
          if new_file_name and #new_file_name > 0 then
            local new_file_path = new_dir .. "/" .. new_file_name
            vim.fn.mkdir(new_dir, "p")                 -- Ensure the directory exists
            vim.fn.rename(current_file, new_file_path) -- Move the file
            vim.cmd("e " .. new_file_path)             -- Open the new file
            vim.cmd("bw " .. current_file)             -- Close the old file
          else
            print("Move cancelled")
          end
        end)
      end)
      return true
    end,
  })
end, { desc = "Move file to a new directory" })
