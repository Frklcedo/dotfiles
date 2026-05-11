return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		-- tag = '0.1.8',
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				-- theme = "ivy"
				layout_strategy = "bottom_pane",
				layout_config = {
					prompt_position = "bottom",
					-- anchor = 'S',
					-- -- mirror = true,
					-- height = 0.50,
					-- width = 0.99,
				},
			},
		},
	},
}
