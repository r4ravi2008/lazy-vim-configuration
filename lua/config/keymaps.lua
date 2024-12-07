-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Window navigation keymaps
map("i", "jk", "<ESC>", opts)
map("n", "<leader>as", "<cmd>CopilotChatSaveWithInput<CR>", opts)
