return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "OXY2DEV/markview.nvim" },
		lazy = false,
		build = ":TSUpdate",
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 1,
		},
	},

	{
		"windwp/nvim-ts-autotag",
        lazy = false,
		opts = {
		},
	},

	-- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- {
	--     "kylechui/nvim-surround",
	--     version = "*",
	--     event = "VeryLazy",
	--     opts = {}
	-- },
}
