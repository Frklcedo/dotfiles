local installed, markview = pcall(require, "markview")

if not installed then
	return
end

vim.g.markview_blink_loaded = true

markview.setup({
	preview = {
		icon_provider = "mini",
	},
})
