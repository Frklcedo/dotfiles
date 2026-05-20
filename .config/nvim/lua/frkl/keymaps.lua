-- keybindings

local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Better window navigation
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
-- vim.keymap.set("n", "<leader>Y", [["+Y]], opts)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)

vim.keymap.set("n", "<leader>wv", "<C-w>v", opts)
vim.keymap.set("n", "<leader>ws", "<C-w>s", opts)
vim.keymap.set("n", "<leader>wc", ":q!<CR>", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

vim.keymap.set("n", "<leader>e", ":Ex<cr>", opts)
vim.keymap.set("n", "<leader>E", ":Lex 30<cr>", opts)
-- vim.keymap.set("n", "<leader>E", vim.cmd.Ex, opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>bk", ":bdelete<CR>", opts)

-- Navigate tabs
vim.keymap.set("n", "<M-h>", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<M-l>", ":tabnext<CR>", opts)
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tk", ":tabclose<CR>", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-S-k>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-S-j>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-S-h>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-S-l>", ":vertical resize -2<CR>", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
-- vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
-- vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
vim.keymap.set("x", "<S-j>", "<Nop>", opts)
vim.keymap.set("x", "<S-k>", "<Nop>", opts)

vim.keymap.set("i", "<C-k>", "<C-p>", opts)
vim.keymap.set("i", "<C-j>", "<C-n>", opts)

vim.keymap.set("n", "<M-q>", "<cmd>cclose<CR>zz", opts)

vim.keymap.set("n", "<leader>m", "`", opts)

vim.keymap.set("n", "<leader>pu", function()
	vim.pack.update()
end, with_desc(opts, "vim.pack update"))

vim.keymap.set("n", "<leader>pc", function()
	local packs = vim.pack.get()
	local names = vim.tbl_map(function(p)
		return p.spec.name
	end, packs)

	vim.ui.select(names, { prompt = "Delete plugin:" }, function(choice)
		if not choice then
			return
		end
		vim.pack.del({ choice })
	end)
end, with_desc(opts, "vim.pack: delete"))

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		local qf_opts = { buffer = true, silent = true }
		vim.keymap.set("n", "<C-q>", function()
			vim.cmd("cclose")
		end, qf_opts)
		vim.keymap.set("n", "<M-j>", function()
			local next, res = pcall(vim.cmd, "cnext")
			if not next then
				local first, res = pcall(vim.cmd, "cfirst")
			end
			pcall(vim.cmd, "normal! zz")
			vim.cmd("copen")
		end, qf_opts)
		vim.keymap.set("n", "<M-k>", function()
			local prev, res = pcall(vim.cmd, "cprevious")
			if not prev then
				local last, res = pcall(vim.cmd, "clast")
			end
			pcall(vim.cmd, "normal! zz")
			vim.cmd("copen")
		end, qf_opts)
	end,
})
