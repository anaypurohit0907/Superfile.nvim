local api = vim.api

local M = {
	state = {
		bufnr = -1,
	},
	_cfg = {
		key = "<C-s>", -- default; can be overridden or set to false
	},
}

local function is_buf_valid(buf)
	return buf > 0 and api.nvim_buf_is_valid(buf)
end

local function spf_run()
	-- Open a terminal running `spf` and enter insert (terminal) mode
	vim.cmd("terminal spf")
	vim.cmd("startinsert")

	local buf = api.nvim_get_current_buf()
	M.state.bufnr = buf

	-- Buffer-local close keymaps for this terminal
	-- Normal mode: <C-q> closes the buffer
	vim.keymap.set("n", "<C-q>", ":bdelete!<CR>", { buffer = buf, silent = true, desc = "Close spf terminal" })

	-- Terminal mode: <Esc> leaves terminal mode and closes the buffer (matches original behavior)
	vim.keymap.set(
		"t",
		"<Esc>",
		[[<C-\><C-n>:bdelete!<CR>]],
		{ buffer = buf, silent = true, desc = "Close spf terminal" }
	)

	-- Clear stale state if the job exits
	api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		once = true,
		callback = function()
			if M.state.bufnr == buf then
				M.state.bufnr = -1
			end
		end,
	})
end

local function spf()
	local buf = M.state.bufnr
	if not is_buf_valid(buf) then
		M.state.bufnr = -1
		spf_run()
		return
	end

	-- Jump to existing terminal buffer and enter insert mode
	api.nvim_set_current_buf(buf)
	vim.cmd("startinsert")
end

function M.setup(opts)
	opts = opts or {}
	-- Merge options (simple assignment is fine here; tbl_extend could be used if expanding later)
	if opts.key ~= nil then
		M._cfg.key = opts.key
	end

	-- Create default/global mapping if enabled
	if M._cfg.key then
		-- Map in both normal and terminal modes so it works from anywhere
		vim.keymap.set({ "n", "t" }, M._cfg.key, spf, {
			desc = "Open/Focus spf terminal",
			silent = true,
		})
	end
end

-- For direct use without setup(), keep a safe default mapping
-- Comment this out if the plugin is only used via setup()
-- M.setup()
M.open = spf -- expose the toggle/focus function
function M.setup(opts)
	opts = opts or {}
	local key = opts.key
	if key == nil then
		key = "<C-s>"
	end
	if key then
		vim.keymap.set({ "n", "t" }, key, spf, { desc = "Open/Focus spf terminal", silent = true })
	end
end
return M
