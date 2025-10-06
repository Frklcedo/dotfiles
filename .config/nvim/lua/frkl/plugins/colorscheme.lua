return {
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                options = {
                    transparency = true
                },
                highlights = {
                    -- LineNr = {
                    MiniIndentscopeSymbol = {
                        fg = "#6B6EBF"
                    },
                    -- CursorLineNr = {
                    --     fg = "#FF90BE"
                    -- },

                    MiniStatuslineModeNormal = {
                        bg = "#FF90BE",
                        fg = "#282c34"
                    },
                    MiniStatuslineModeVisual = {
                        bg = "#c678dd",
                        fg = "#282c34"
                    },
                    MiniStatuslineModeCommand = {
                        bg = "#6B6EBF",
                        fg = "#dcdfe4"
                    },

                    MiniTablineCurrent = {
                        bg = "#6B6EBF",
                        fg = "#dcdfe4"
                    },
                    MiniStatuslineGitInfo = {
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
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        -- config = function()
        --   vim.cmd([[colorscheme tokyonight]])
        -- end,
    },
}
