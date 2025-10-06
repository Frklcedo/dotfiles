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
        "lambdalisue/suda.vim",
        init = function()
            vim.g.suda_smart_edit = 1
        end,
    }
}
