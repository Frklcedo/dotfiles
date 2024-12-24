return {
    {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
    {
        'williamboman/mason.nvim',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
        },
        lazy = false,
    },

    { 'neovim/nvim-lspconfig' },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    {
        "brenoprata10/nvim-highlight-colors",
        opts = {}
    },

}
