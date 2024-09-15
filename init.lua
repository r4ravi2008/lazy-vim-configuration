-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("CopilotChat").setup({
  model = "gpt-4",
})

vim.api.nvim_set_keymap("n", "<leader>as", [[:CopilotChatSaveWithInput<CR>]], { noremap = true, silent = true })

-- Function to save session with user input
function _G.save_session()
  vim.ui.input({ prompt = "Enter session name: " }, function(input)
    if input then
      vim.cmd("CopilotChatSave " .. input)
    end
  end)
end

vim.cmd([[command! CopilotChatSaveWithInput lua _G.save_session()]])
vim.api.nvim_set_keymap("n", "<leader>as", [[:CopilotChatSaveWithInput<CR>]], { noremap = true, silent = true })

function _G.load_session()
  local path = "/Users/rkommineni/.local/share/nvim/copilotchat_history/"
  local files = vim.fn.glob(path .. "*.json", false, true)
  local sessions = {}

  for _, file in ipairs(files) do
    local session_name = vim.fn.fnamemodify(file, ":t:r")
    table.insert(sessions, session_name)
  end

  vim.ui.select(sessions, {
    prompt = "Select a session to load:",
  }, function(choice)
    if choice then
      vim.cmd("CopilotChatLoad " .. choice)
    end
  end)
end

vim.cmd([[command! CopilotChatLoadFromDropdown lua _G.load_session()]])
vim.api.nvim_set_keymap("n", "<leader>al", [[:CopilotChatLoadFromDropdown<CR>]], { noremap = true, silent = true })

local telescope = require("telescope")
local builtin = require("telescope.builtin")

function _G.search_org_dir(keyword)
  builtin.live_grep({
    prompt_title = "< Search >",
    cwd = "~/gtd/",
    search = keyword,
  })
end

vim.cmd([[command! SearchOrgDirectory lua _G.search_org_dir()]])
vim.api.nvim_set_keymap("n", "<leader>sz", [[:SearchOrgDirectory<CR>]], { noremap = true, silent = true })

-- local lfs = require("lfs")
--
-- function _G.list_org_files()
--   local org_files = {}
--   for file in lfs.dir("~/gtd") do
--     if file:match("%.org$") then
--       local path = "~/gtd" .. "/" .. file
--       table.insert(org_files, path)
--     end
--   end
--   return org_files
-- end
--

-- neovide configuration
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", "<C-R>+") -- Paste insert modula2_default_extension
  vim.api.nvim_set_keymap(
    "n",
    "<C-+>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<C-->",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end

-- grep in current buffer directory
function _G.grep_in_current_dir()
  local current_dir = vim.fn.expand("%:p:h")
  builtin.live_grep({
    prompt_title = "< Search >",
    cwd = current_dir,
  })
end

vim.cmd([[command! GrepCurrent lua _G.grep_in_current_dir()]])
vim.api.nvim_set_keymap("n", "<leader>sf", [[:GrepCurrent<CR> ]], { noremap = true, silent = true })

-- magick lua path
package.path = package.path .. ";" .. "/Users/rkommineni/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. "/Users/rkommineni/.luarocks/share/lua/5.1/?.lua"
