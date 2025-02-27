-- ~/.config/nvim/lua/plugins/my_spf_plugin/init.lua

local keymaps = require("plugins.my_spf_plugin.keymaps")

return {
	-- Optional: Add dependencies if your plugin requires any
	-- dependencies = { 'nvim-telescope/telescope.nvim' },

	config = function()
		keymaps.setup()
	end,
}
