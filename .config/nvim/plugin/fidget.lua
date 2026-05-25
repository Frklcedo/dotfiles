local installed, fidget = pcall(require, "fidget")

if not installed then
	vim.notify("'fidget' not installed", vim.log.levels.ERROR)
	return
end

fidget.setup()
