return {
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<C-CR>", "<cmd>TmuxNavigatePrevious<cr>", mode = "n", desc = "Go to the previous pane" },
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = "n", desc = "Got to the left pane" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = "n", desc = "Got to the down pane" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = "n", desc = "Got to the up pane" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = "n", desc = "Got to the right pane" },
  },
}
