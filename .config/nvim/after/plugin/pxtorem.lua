local installed, pxtorem = pcall(require, "nvim-px-to-rem")

if not installed then
    vim.notify("'nvim-px-to-rem' not installed", vim.log.levels.ERROR)
    return
end

pxtorem.setup()
