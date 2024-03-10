local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { { "prettierd", "prettier" } },
		php = { { "pint", "php_cs_fixer" } },
	},
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(args)
		require("conform").format({
			lsp_fallback = true,
			bufnr = args.buf,
		})
	end,
})
