local telescope = require("telescope")
local opts = {}

vim.keymap.set("n", "<leader>lr", function ()
    telescope.extensions.laravel.routes({
        layout_strategy = 'vertical',
    })
end, opts)

