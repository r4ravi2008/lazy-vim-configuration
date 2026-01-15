-- Configure terminal mode keymaps for tmux navigation
-- This allows Ctrl+h/j/k/l to navigate tmux panes even when in terminal buffers (like lazygit)
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Create an autocmd to set up terminal keymaps when entering terminal mode
    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()

        -- Function to navigate tmux panes from terminal mode
        local function tmux_navigate(direction)
          return function()
            -- Send the tmux command directly - this navigates without leaving terminal mode
            vim.fn.system("tmux select-pane -" .. direction)
          end
        end

        -- Set buffer-local terminal mode keymaps
        vim.keymap.set("t", "<C-h>", tmux_navigate("L"), { buffer = buf, desc = "Navigate left tmux pane" })
        vim.keymap.set("t", "<C-j>", tmux_navigate("D"), { buffer = buf, desc = "Navigate down tmux pane" })
        vim.keymap.set("t", "<C-k>", tmux_navigate("U"), { buffer = buf, desc = "Navigate up tmux pane" })
        vim.keymap.set("t", "<C-l>", tmux_navigate("R"), { buffer = buf, desc = "Navigate right tmux pane" })
      end,
    })
    return opts
  end,
}

