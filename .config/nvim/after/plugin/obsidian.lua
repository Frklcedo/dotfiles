local installed, obsidian = pcall(require, "obsidian")

if not installed then
	vim.notify("'obsidian not installed'", vim.log.levels.ERROR)
	return
end

---@module 'obsidian'
---@type obsidian.config
local opts = {
	legacy_commands = false,
    workspaces = {
        {
            name = "personal",
            path = "~/notes/personal"
        },
    },
    picker = {
        name = "telescope.nvim"
    },
}

obsidian.setup(opts)

function obsidian_keymaps()
    local kopts = { noremap = true }

    vim.keymap.set("n", "<leader>nn", ":Obsidian new ", kopts)
    vim.keymap.set("n", "<leader>np", ":Obsidian search<CR>", kopts)
    vim.keymap.set("n", "<leader>nO", ":Obsidian open<CR>", kopts)
    vim.keymap.set("n", "<leader>nr", ":Obsidian rename<CR>", kopts)
end

obsidian_keymaps()
