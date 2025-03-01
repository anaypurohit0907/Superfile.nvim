local keymaps = require("./keymaps.lua")

return {
	-- Optional: Add dependencies if your plugin requires any
	-- dependencies = { 'nvim-telescope/telescope.nvim' },

	config = function()
		keymaps.setup()
	end,
}
