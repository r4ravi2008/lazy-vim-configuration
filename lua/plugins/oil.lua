return {
  "stevearc/oil.nvim",
  lazy = false, -- Recommended not to lazy load for performance
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- For icons

  keys = {
    -- suggested keymap to open oil
    { "<leader>fo", "<cmd>Oil<cr>", desc = "Open Oil" },
    {
      "yp",
      function()
        require("oil.actions").copy_entry_path.callback()
        vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
      end,
      mode = "n",
      desc = "Copy filepath to system clipboard (Oil)",
      buffer = true, -- Ensure this keymap only applies in Oil buffer
    },
    {
      "<leader>%",
      ":let @+=expand('%:p')<CR>",
      mode = "n",
      desc = "Copy current file path",
    },
  },

  opts = {
    view_options = {
      show_hidden = true, -- Show hidden files
    },
  },
}
