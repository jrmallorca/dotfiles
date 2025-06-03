return {
  {
    "folke/snacks.nvim",
    keys = {
      { -- https://github.com/folke/snacks.nvim/issues/1036#issuecomment-2734330151
        "<leader>mv",
        function()
          local root_patterns = { ".git", ".obsidian" }
          local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
          local current_file = vim.fn.expand("%:p")
          local current_file_name = vim.fn.fnamemodify(current_file, ":t")

          Snacks.picker.pick({
            cwd = root_dir,
            title = "Directories",
            format = "text",
            finder = function(opts, ctx)
              local proc_opts = {
                cmd = "fd",
                args = { ".", "--type", "directory", "--exclude", "./.git/*" },
              }
              return require("snacks.picker.source.proc").proc({ opts, proc_opts }, ctx)
            end,
            confirm = function(picker, item)
              picker:close()
              if item then
                -- Ask for confirmation/edit of new filename
                vim.ui.input({ prompt = "New filename: ", default = current_file_name }, function(new_file_name)
                  if new_file_name and #new_file_name > 0 then
                    local new_file_path = root_dir .. "/" .. item.text .. "/" .. new_file_name
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
        desc = "Move files into directory through fuzzy finding.",
      },
    },
  },
}
