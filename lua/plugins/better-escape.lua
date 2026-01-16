return {
  "max397574/better-escape.nvim",
  event = { "InsertEnter", "TermOpen" },
  config = function()
    require("better_escape").setup({
      timeout = 150,
      mappings = {
        i = {
          j = { k = "<Esc>" },
          k = { j = "<Esc>" },
        },
        t = {
          j = { k = "<C-\\><C-n>" },
          k = { j = "<C-\\><C-n>" },
        },
      },
    })
  end,
}
