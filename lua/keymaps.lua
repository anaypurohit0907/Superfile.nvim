-- ~/.config/nvim/lua/plugins/my_spf_plugin/keymaps.lua

local function run_spf()
	vim.cmd("spf")
end

local M = {}

function M.setup()
	-- Default keymap
	local default_keymap = "<C-f>"

	-- Check if the user has defined a custom keymap in their nvimrc
	local custom_keymap = vim.g.my_spf_plugin_keymap

	-- Use the custom keymap if it exists, otherwise use the default
	local keymap = custom_keymap or default_keymap

	vim.keymap.set("n", keymap, run_spf, { desc = "Run spf command" })
end

return M
