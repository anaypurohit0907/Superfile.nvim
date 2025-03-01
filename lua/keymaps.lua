local function run_spf()
	-- Check if a terminal buffer exists
	local term_buf = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "terminal" then
			term_buf = buf
			break
		end
	end

	if term_buf then
		vim.api.nvim_command("terminal spf")
		vim.api.nvim_command("insert!")
	else
		vim.api.nvim_command("terminal spf")
		vim.api.nvim_command("insert!")
	end
end

local M = {}

function M.setup()
	-- Default keymap
	local default_keymap = "<C-s>"

	-- Check if the user has defined a custom keymap in their nvimrc
	local custom_keymap = vim.g.superfile_keymap

	-- Use the custom keymap if it exists, otherwise use the default
	local keymap = custom_keymap or default_keymap

	vim.keymap.set("n", keymap, run_spf, { desc = "Open superfile command" })
end

return M
