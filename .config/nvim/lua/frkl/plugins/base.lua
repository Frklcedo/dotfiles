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
                    MiniStatuslineModeNormal = {
                        bg = "#6B6EBF",
                        fg = "#dcdfe4"
                    },
                    MiniStatuslineModeVisual = {
                        bg = "#FF90BE",
                        fg = "#282c34"
                    },
                    MiniStatuslineModeCommand = {
                        bg = "#c678dd",
                        fg = "#282c34"
                    },
                    MiniTablineCurrent = {
                        bg = "#6B6EBF",
                        fg = "#dcdfe4"
                    },
                    statuslineGitinfo = {
                        bg = "#98c379",
                        fg = "#282c34",
                    },
                    statuslineDevinfo = {
                        bg = "#FF90BE",
                        fg = "#282c34"
                    }
                }
            })
            vim.cmd([[colorscheme onedark]])
        end,
    },

    {
        "lambdalisue/suda.vim",
        init = function()
            vim.g.suda_smart_edit = 1
        end,
    }
}
