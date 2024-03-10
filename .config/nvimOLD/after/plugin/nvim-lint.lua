local lint = require("lint")
local phpcs = lint.linters.phpcs

phpcs.args = {
	-- <- Add a new parameter here
	"--report=json",
	"--exclude=Generic.Commenting.Todo,Squiz.PHP.CommentedOutCode",
}
lint.linters_by_ft = {
	php = { "phpcs" },
	js = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "TextChanged" }, {
	group = lint_augroup,
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end,
})
