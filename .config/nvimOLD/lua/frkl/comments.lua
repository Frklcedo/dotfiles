local comment = require("Comment")
local tsctx = require("ts_context_commentstring")

tsctx.setup({
	enable_autocmd = false,
})
comment.setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
