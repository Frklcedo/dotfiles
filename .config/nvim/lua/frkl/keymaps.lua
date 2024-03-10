-- keybindings
-- local opts = { noremap = true, silent = true }
local opts = { noremap = true }

-- local term_opts = { silent = true }

local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Better window navigation
keymap({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

keymap("n", "<leader>wv", "<C-w>v", opts)
keymap("n", "<leader>ws", "<C-w>s", opts)
keymap("n", "<leader>wc", ":q!<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

keymap("n", "<leader>e", ":Ex<cr>", opts)
keymap("n", "<leader>E", ":Lex 30<cr>", opts)
-- keymap("n", "<leader>E", vim.cmd.Ex, opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bk", ":bdelete<CR>", opts)

-- Resize with arrows
keymap("n", "<C-S-k>", ":resize -2<CR>", opts)
keymap("n", "<C-S-j>", ":resize +2<CR>", opts)
keymap("n", "<C-S-h>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-S-l>", ":vertical resize -2<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<S-j>", "<Nop>", opts)
keymap("x", "<S-k>", "<Nop>", opts)

-- emmet html
-- keymap("", "<C-t>", "<Nop>", opts)
-- keymap({ "i", "n" }, "<C-t>t", "<C-t>,", opts)
