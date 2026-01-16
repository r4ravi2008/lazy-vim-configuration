-- Snacks.nvim configuration
-- Add keymaps for floating terminal windows (like lazygit) to navigate to tmux panes
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Configure lazygit to use maximum space
    opts.lazygit = {
      win = {
        width = 0,  -- 0 means full width
        height = 0, -- 0 means full height
      },
    }
    -- Function to navigate directly to tmux pane
    local function tmux_navigate(direction)
      local tmux_dir = ({ h = "L", j = "D", k = "U", l = "R" })[direction]
      vim.fn.system("tmux select-pane -" .. tmux_dir .. " -Z")
    end

    -- Fix scrambled terminal UI (lazygit) when returning from tmux pane
    -- Resize window to force lazygit to redraw
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()
        local snacks_term = vim.b[buf].snacks_terminal
        
        -- Check if we're in a snacks terminal running lazygit
        if snacks_term and snacks_term.cmd then
          local cmd = snacks_term.cmd
          local is_lazygit = (type(cmd) == "string" and cmd:match("lazygit"))
            or (type(cmd) == "table" and vim.tbl_contains(cmd, "lazygit"))
          
          if is_lazygit and vim.api.nvim_win_is_valid(win) then
            vim.defer_fn(function()
              if not vim.api.nvim_win_is_valid(win) then return end
              
              -- Get current config and resize to force SIGWINCH
              local config = vim.api.nvim_win_get_config(win)
              if config.relative ~= "" then
                local orig_width = config.width
                local orig_height = config.height
                
                -- Shrink window
                config.width = orig_width - 2
                config.height = orig_height - 2
                pcall(vim.api.nvim_win_set_config, win, config)
                
                -- Restore after a brief delay
                vim.defer_fn(function()
                  if vim.api.nvim_win_is_valid(win) then
                    config.width = orig_width
                    config.height = orig_height
                    pcall(vim.api.nvim_win_set_config, win, config)
                  end
                end, 50)
              end
            end, 50)
          end
        end
      end,
    })

    -- Set up autocmd to add keymaps for floating terminal windows
    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function()
        -- Small delay to let the window configuration settle
        vim.defer_fn(function()
          local buf = vim.api.nvim_get_current_buf()
          local win = vim.api.nvim_get_current_win()
          
          -- Check if this is a valid window and buffer
          if not vim.api.nvim_win_is_valid(win) or not vim.api.nvim_buf_is_valid(buf) then
            return
          end
          
          local win_config = vim.api.nvim_win_get_config(win)
          
          -- Only add these keymaps for floating windows
          if win_config.relative ~= "" then
            local keymap_opts = { buffer = buf, silent = true }
            
            vim.keymap.set("t", "<C-h>", function() tmux_navigate("h") end, keymap_opts)
            vim.keymap.set("t", "<C-j>", function() tmux_navigate("j") end, keymap_opts)
            vim.keymap.set("t", "<C-k>", function() tmux_navigate("k") end, keymap_opts)
            vim.keymap.set("t", "<C-l>", function() tmux_navigate("l") end, keymap_opts)
          end
        end, 10)
      end,
    })

    return opts
  end,
}

