local installed, comment = pcall(require, "Comment")
if not installed then
	vim.notify("'Comment' not installed", vim.log.levels.ERROR)
	return
end

require("ts_context_commentstring").setup({ enable_autocmd = false })

comment.setup({
	pre_hook = function(ctx)
		local pre_configured_ft = { "sql", "mysql", "plsql" }

		if vim.tbl_contains(pre_configured_ft, vim.bo.filetype) then
			return vim.bo.commentstring
		end

		local ts_context = require("ts_context_commentstring.integrations.comment_nvim")
		return ts_context.create_pre_hook()(ctx)
	end,
})
