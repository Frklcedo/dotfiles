return {
    {
        'nvimtools/none-ls.nvim',
        requires = { "nvim-lua/plenary.nvim" },

        opts = {
            sources = {
                -- null_ls.builtins.diagnostics.phpcs
            },
        },
        -- config = function()
        --     local null_ls = require("null-ls")
        --
        --     null_ls.setup({
        --     })
        -- end,
    }
}
