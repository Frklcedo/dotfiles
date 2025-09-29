return {
    {
        'nvimtools/none-ls.nvim',
        requires = { "nvim-lua/plenary.nvim" },

        -- opts = {
        --     sources = {
        --         -- null_ls.builtins.diagnostics.phpstan,
        --         -- null_ls.builtins.diagnostics.phpcs,
        --         null_ls.builtins.diagnostics.phpmd,
        --     },
        -- },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- null_ls.builtins.diagnostics.phpstan,
                    -- null_ls.builtins.diagnostics.phpcs,
                    null_ls.builtins.formatting.pint
                },
            })
        end,
    }
}
