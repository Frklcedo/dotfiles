
local telescope = require('telescope')

telescope.setup({
  defaults = {
    -- layout_strategy = 'vertical',
    --[[ layout_config = {
    } ]]
  },
})

telescope.load_extension('fzf')

local builtin = require("telescope.builtin")
local opts = {}

vim.keymap.set("n", "<leader><leader>", builtin.find_files, opts)
vim.keymap.set("n", "<C-p>", builtin.git_files, opts)
vim.keymap.set("n", "<leader>bl", builtin.buffers, opts)
vim.keymap.set("n", "<leader>/", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>cs", builtin.lsp_dynamic_workspace_symbols, opts)
vim.keymap.set("n", "<leader>cp", builtin.lsp_references, opts)
vim.keymap.set("n", "<leader>hk", builtin.keymaps, opts)
vim.keymap.set("n", "<leader>hc", builtin.commands, opts)

vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts)
vim.keymap.set("n", "<leader>gs", builtin.git_stash, opts)
vim.keymap.set("n", "<leader>gc", builtin.git_commits, opts)
vim.keymap.set("n", "<leader>g.", builtin.git_bcommits, opts)


vim.keymap.set("n", "<leader>fw", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, opts)

