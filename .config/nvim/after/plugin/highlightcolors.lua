local installed, colors = pcall(require, "nvim-highlight-colors")

if not installed then
    vim.notify('"nvim-highlight-colors" not installed', vim.log.levels.ERROR)
    return
end

colors.setup({})

