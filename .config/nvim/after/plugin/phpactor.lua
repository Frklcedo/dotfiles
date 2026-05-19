local Float = require("plenary.window.float")

local function showWindow(title, syntax, contents)
	local out = vim.split(contents, "\n", { plain = true })

	local float = Float.percentage_range_window(0.6, 0.4, { winblend = 0 }, {
		title = title,
		topleft = "┌",
		topright = "┐",
		top = "─",
		left = "│",
		right = "│",
		botleft = "└",
		botright = "┘",
		bot = "─",
	})

	vim.bo[float.bufnr].filetype = syntax
	vim.api.nvim_buf_set_lines(float.bufnr, 0, -1, false, out)
end

local function reindex()
	vim.lsp.buf_notify(0, "phpactor/indexer/reindex", {})
end

local function dumpconfig()
	local results, _ = vim.lsp.buf_request_sync(0, "phpactor/debug/config", { ["return"] = true })
	for _, res in pairs(results or {}) do
		pcall(showWindow, "Phpactor LSP Configuration", "json", res["result"])
	end
end
local function status()
	local results, _ = vim.lsp.buf_request_sync(0, "phpactor/status", { ["return"] = true })
	for _, res in pairs(results or {}) do
		pcall(showWindow, "Phpactor Status", "markdown", res["result"])
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "php",
	callback = function()
		vim.api.nvim_buf_create_user_command(0, "LspPhpActorReindex", reindex, {})
		vim.api.nvim_buf_create_user_command(0, "LspPhpActorDumpConfig", dumpconfig, {})
		vim.api.nvim_buf_create_user_command(0, "LspPhpActorStatus", status, {})
	end,
})
