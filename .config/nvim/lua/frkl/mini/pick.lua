local pick = require("mini.pick")
local extra = require("mini.extra")

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
        mark    = "<M-m>",
        choose    = '<CR>',

        scroll_down  = '<C-d>',
        scroll_left  = '<C-h>',
        scroll_right = '<C-l>',
        scroll_up    = '<C-p>',
    },
	window = { config = win_config },
    options = {
      content_from_bottom = true,
    },
}

pick.setup(opts)
extra.setup()

vim.keymap.set("n", "<leader><leader>", pick.builtin.files, { desc = "MiniPick: find files" })
vim.keymap.set("n", "<C-p>", function()
	pick.builtin.files({ tool = "git" })
end, { desc = "MiniPick: find git files" })
vim.keymap.set("n", "<leader>bl", pick.builtin.buffers, { desc = "MiniPick: find buffer files" })

vim.keymap.set("n", "<leader>/", pick.builtin.grep, { desc = "MiniPick: Find by grep string"})
vim.keymap.set("n", "<leader>fw", pick.builtin.grep_live, { desc = "MiniPick: Find by live grep"})
