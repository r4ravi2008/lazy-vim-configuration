return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  vscode = true,
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    -- suggested keymap
    { "<leader>fo", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}
