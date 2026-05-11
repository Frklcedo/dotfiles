local pre_installed_parsers = {
	"c",
	"lua",
	"markdown",
	"markdown_inline",
	"query",
	"vim",
	"vimdoc",
}

local file_types = {
	"php",
	"html",
	"css",
	"javascript",
	"json",
	"vue",
	"typescript",
	"tsx",
	"blade",
}
local treesitter = require("nvim-treesitter")
treesitter.install(file_types)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if vim.list_contains(treesitter.get_available(), lang) then
			local lang_installed = vim.list_contains(treesitter.get_installed(), lang)
				or vim.list_contains(pre_installed_parsers, lang)
			if lang_installed then
				-- Enable tree-sitter highlighting
				vim.treesitter.start()

				-- -- Enable tree-sitter folds
				-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				-- vim.wo[0][0].foldmethod = "expr"

				-- Enable tree-sitter indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end
	end,
})

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		vim.bo.commentstring = "-- %s"
	end,
})
