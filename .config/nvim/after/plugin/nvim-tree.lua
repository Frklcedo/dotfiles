-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup(
-- {
--   filters = {
--     dotfiles = false,
--   },
-- }
)

local opts = { silent = true }

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
vim.keymap.set("n", "<leader>E", ":NvimTreeFocus<cr>", opts)
vim.keymap.set("n", "<leader><C-e>", ":NvimTreeCollapse<cr>", opts)

