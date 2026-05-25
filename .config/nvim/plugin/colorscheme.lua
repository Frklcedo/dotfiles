local installed, colorscheme = pcall(require, "onedarkpro")

if not installed then
    vim.notify("onedarkpro not installed", vim.log.levels.ERROR)
end

local highlights = {
	-- LineNr = {}
	-- CursorLineNr = { fg = "#FF90BE" },
	MiniIndentscopeSymbol = { fg = "#6B6EBF" },
	MiniStatuslineModeNormal = { bg = "#FF90BE", fg = "#282c34" },
	MiniStatuslineModeVisual = { bg = "#c678dd", fg = "#282c34", },
	MiniStatuslineModeCommand = { bg = "#6B6EBF", fg = "#dcdfe4", },
	MiniTablineCurrent = { bg = "#6B6EBF", fg = "#dcdfe4", },
	MiniStatuslineGitInfo = { bg = "#98c379", fg = "#282c34", },
	statuslineDevinfo = { bg = "#FF90BE", fg = "#282c34", },
}

colorscheme.setup({
    options = {
        transparency = true,
    },
    highlights = highlights,
})
vim.cmd.colorscheme("onedark")
