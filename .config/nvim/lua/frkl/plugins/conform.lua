return {
	{
		"stevearc/conform.nvim",
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				php = { "pint" },
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
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
