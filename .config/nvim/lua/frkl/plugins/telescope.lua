return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
        },
        opts = {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    -- prompt_position = 'top',
                    -- anchor = 'S',
                    -- mirror = true,
                    height = 0.75
                }
            },
        }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
}
