vim.g.markview_blink_loaded = true

local M = {}

M.specs = {
	-- notes
	-- "https://github.com/nvim-neorg/neorg",
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
	"https://github.com/OXY2DEV/markview.nvim",
}

M.setup = function()
	require("markview").setup({
		preview = {
			icon_provider = "mini",
		},
	})
end

return M
