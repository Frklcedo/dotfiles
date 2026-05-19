local installed, whichkey = pcall(require, "which-key")
if not installed then
	vim.notify("'which-key' not installed", vim.log.levels.ERROR)
	return
end

whichkey.setup({
    preset = "classic"
})

vim.keymap.set("n", "<leader>?", function()
	whichkey.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
