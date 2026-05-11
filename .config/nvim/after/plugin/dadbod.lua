--[[ vim.api.nvim_create_autocmd("FileType", {
	pattern = { "mysql", "plsql" },
	callback = function(args)
		vim.bo[args.buf].filetype = "sql"
	end,
}) ]]
