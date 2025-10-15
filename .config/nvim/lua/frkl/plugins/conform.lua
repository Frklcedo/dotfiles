return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				php = { "pint" },
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				["clang-format"] = {
					append_args = {
						"--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, ColumnLimit: 120, BreakBeforeBraces: Allman, AllowShortFunctionsOnASingleLine: None, SpacesInParentheses: false}",
					},
				},
			},
		},
	},
}
