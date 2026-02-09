return {
  {
    "folke/snacks.nvim",
    keys = {
      { -- https://github.com/folke/snacks.nvim/issues/1036#issuecomment-2734330151
        "<leader>mv",
        desc = "Move files into directory through fuzzy finding.",
        function()
          local root_patterns = { ".git", ".obsidian" }
          local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
          local current_file = vim.fn.expand("%:p")
          local current_file_name = vim.fn.fnamemodify(current_file, ":t")

          Snacks.picker.files({
            dirs = { root_dir },
            title = "Directories",
            layout = { preset = "select", layout = { max_width = 50 } },
            hidden = true,
            follow = true,
            cmd = "fd",
            args = { "--type", "d" },
            transform = function(item)
              return vim.fn.isdirectory(item.file) == 1
            end,
            confirm = function(picker, item)
              picker:close()
              Snacks.notify.info(item.text)
              if item then
                -- Ask for confirmation/edit of new filename
                vim.ui.input({ prompt = "New filename: ", default = current_file_name }, function(new_file_name)
                  if new_file_name and #new_file_name > 0 then
                    local new_file_path = item.text .. "/" .. new_file_name
                    vim.fn.rename(current_file, new_file_path) -- Move the file
                    vim.cmd("e " .. new_file_path) -- Open the new file
                    vim.cmd("bw " .. current_file) -- Close the old file
                  else
                    print("Move cancelled")
                  end
                end)
              end
            end,
          })
        end,
      },
    },
  },
}
