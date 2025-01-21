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
        "brenoprata10/nvim-highlight-colors",
        opts = {}
    },

}
