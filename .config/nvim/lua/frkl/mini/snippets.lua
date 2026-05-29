local installed, mini_snippets = pcall(require, "mini.snippets")

if not installed then
	vim.notify("mini.snippets not installed", vim.log.levels.ERROR)
end
local gen_loader = mini_snippets.gen_loader

local function extend_filetypes(lang, fts)
	local new_patterns = {}
	local default_patterns = {
		lang .. "/**/*.json",
		lang .. "/**/*.lua",
		"**/" .. lang .. ".json",
		"**/" .. lang .. ".lua",
	}

	for _, ft in ipairs(fts) do
		table.insert(new_patterns, "**/" .. ft .. "/**/*.json")
		table.insert(new_patterns, "**/" .. ft .. "/**/*.lua")
	end

	return vim.list_extend(default_patterns, new_patterns)
end

local lang_config = {
	lang_patterns = {
		typescript = extend_filetypes("typescript", { "vue" }),
		javascript = extend_filetypes("javascript", { "vue" }),
		blade = extend_filetypes("blade", { "blade" }),
		html = extend_filetypes("html", { "php" }),
	},
}

mini_snippets.setup({
	snippets = {
		gen_loader.from_lang(lang_config),
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),
	},
	mappings = {
		stop = "<C-e>",
		expand = "<M-s>",
	},
})
