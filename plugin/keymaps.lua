local api = vim.api
Bufnr = -1

local function spf_run()
	api.nvim_command("terminal spf")
	api.nvim_command("startinsert")
	local buf = api.nvim_get_current_buf()
	Bufnr = buf

	api.nvim_buf_set_keymap(Bufnr, "n", "<C-q>", ":bdelete!<CR>", {})
	api.nvim_buf_set_keymap(Bufnr, "t", "<esc>", "<C-\\><C-n> :bdelete!<CR>", {})
end

local function spf()
	-- vim.print(Bufnr)
	if Bufnr == -1 then
		spf_run()
		return
	end

	-- Check if a buffer with bufnr exists
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf == Bufnr then
			api.nvim_set_current_buf(Bufnr)
			api.nvim_command("startinsert")
			return
		end
	end

	Bufnr = -1
	spf_run()
end

vim.keymap.set("n", "<C-s>", spf, {})
