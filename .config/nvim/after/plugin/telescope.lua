local builtin = require("telescope.builtin")
local opts = {}

vim.keymap.set("n", "<leader><leader>", builtin.find_files, opts)
vim.keymap.set("n", "<C-p>", builtin.git_files, opts)
vim.keymap.set("n", "<leader>bl", builtin.buffers, opts)
vim.keymap.set("n", "<leader>/", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

