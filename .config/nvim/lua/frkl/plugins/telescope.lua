return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
        },
        opts = {
            defaults = {
                -- theme = "ivy"
                layout_strategy = 'bottom_pane',
                layout_config = {
                    prompt_position = 'bottom',
                    -- anchor = 'S',
                    -- -- mirror = true,
                    -- height = 0.50,
                    -- width = 0.99,
                }
            },
        }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
}
