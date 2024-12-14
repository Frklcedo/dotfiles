return {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        -- config = function()
        --   vim.cmd([[colorscheme tokyonight]])
        -- end,
    },
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                options = {
                    transparency = false
                },
                highlights = {
                    LineNr = {
                        fg = "#6B6EBF"
                    },
                    CursorLineNr = {
                        fg = "#FF90BE"
                    },
                }
            })
            vim.cmd([[colorscheme onedark]])
        end,
    },

    { "lambdalisue/suda.vim" },
}
