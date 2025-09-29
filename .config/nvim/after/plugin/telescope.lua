local telescope = require('telescope')

telescope.load_extension('fzf')
telescope.load_extension('harpoon')

local builtin = require("telescope.builtin")
local opts = {}

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope: find files"})
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope: find git files"})
vim.keymap.set("n", "<leader>bl", builtin.buffers, { desc = "Telescope: find buffer files"})
vim.keymap.set("n", "<leader>/", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope: Find by grep string"})

vim.keymap.set("n", "<leader>cqw", builtin.lsp_dynamic_workspace_symbols, { desc = "Lsp actions: find workspace symbols"})
vim.keymap.set("n", "<leader>cP", builtin.lsp_references, { desc = "Lsp actions: find symbol references"})
vim.keymap.set("n", "<leader>hk", builtin.keymaps, { desc = "Telescope: Find keymaps"})
vim.keymap.set("n", "<leader>hc", builtin.commands, { desc = "Telescope: Find commands"})

vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts)
vim.keymap.set("n", "<leader>gs", builtin.git_stash, opts)
vim.keymap.set("n", "<leader>gc", builtin.git_commits, opts)
vim.keymap.set("n", "<leader>g.", builtin.git_bcommits, opts)


vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Telescope: Find by live grep"})
vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, { desc = "Telescope: Current buffer fzf"})

vim.keymap.set("n", "<leader>h<Space>", ":Telescope harpoon marks<CR>", { desc = "Telescope: Find harpoon marks" })
