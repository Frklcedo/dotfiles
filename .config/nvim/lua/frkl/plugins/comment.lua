return {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = {
				enable_autocmd = false,
			},
		},
	},
	config = function()
		local comment = require("Comment")
        local ft = require("Comment.ft")
		local ts_context = require("ts_context_commentstring.integrations.comment_nvim")
        local pre_hook = ts_context.create_pre_hook()

		comment.setup({
			pre_hook = function (ctx)
                if vim.bo.filetype == "blade" then
                    return vim.bo.commentstring
                else
                    return pre_hook(ctx)
                end
            end,
		})

        ft.set('blade', { '{{-- %s --}}', '{{-- %s --}}' })
	end,
}
