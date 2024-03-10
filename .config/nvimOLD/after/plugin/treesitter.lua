treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
	vim.notify("treesitter not found")
end

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade",
}

treesitter.setup({
	ensure_installed = { "php", "html", "css", "javascript", "json", "vue", "c", "lua", "vim", "vimdoc", "query" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "php", "blade" },
	},
	indend = {
		enable = true,
	},
	autotag = {
		enable = true,
		-- enable_rename = true,
		-- enable_close = true,
		-- enable_close_on_slash = true,
		-- filetypes = {
		-- 	"php",
		-- 	"blade",
		-- 	"html",
		-- 	"javascript",
		-- 	"typescript",
		-- 	"javascriptreact",
		-- 	"typescriptreact",
		-- 	"svelte",
		-- 	"vue",
		-- 	"tsx",
		-- 	"jsx",
		-- 	"rescript",
		-- 	"xml",
		-- 	"markdown",
		-- 	"astro",
		-- 	"glimmer",
		-- 	"handlebars",
		-- 	"hbs",
		-- },
	},
})

vim.api.nvim_exec(
	[[
    augroup BladeFiltypeRelated
        autocmd!
        autocmd BufNewFile,BufRead *.blade.php set ft=blade
    augroup END
]],
	false
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})
