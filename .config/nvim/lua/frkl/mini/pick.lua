local pick = require("mini.pick")

-- Centered on screen
local win_config = function()
	local height = math.floor(0.75 * vim.o.lines)
	local width = math.floor(0.75 * vim.o.columns)
	return {
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

local opts = {
    mappings = {
        move_down  = '<C-j>',
        move_start = '<C-g>',
        move_up    = '<C-k>',
    },
	window = { config = win_config },
}

pick.setup(opts)

vim.keymap.set("n", "<leader><leader>", pick.builtin.files, { desc = "MiniPick: find files" })
vim.keymap.set("n", "<C-p>", function()
	pick.builtin.files({ tool = "git" })
end, { desc = "MiniPick: find git files" })
vim.keymap.set("n", "<leader>bl", pick.builtin.buffers, { desc = "MiniPick: find buffer files" })
