return {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    {
        "lambdalisue/suda.vim",
        init = function()
            vim.g.suda_smart_edit = 1
        end,
    }
}
