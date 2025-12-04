vim.keymap.set("n", "<leader>e", ":Oil ")
vim.keymap.set("n", "<leader>ee", ":Oil .<cr>")

return {
    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<leader>dv"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<leader>ds"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<leader>dt"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["<leader>dp"] = "actions.preview",
                ["<leader>dc"] = "actions.close",
                ["<leader>dl"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false
        },
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
}
