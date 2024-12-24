return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback' },
                ['<Tab>'] = { 'accept', 'fallback' },
                ['<S-Tab>'] = {},
                ['<C-l>'] = { 'snippet_forward', 'fallback' },
                ['<C-h>'] = { 'snippet_backward', 'fallback' },
            },

            completion = {
                list = { selection = "manual" },
                keyword = {
                    regex = '[-_]\\|\\k\\|\\$',
                },
                trigger = {
                    show_on_trigger_character = false
                },
                menu = {
                    draw = {
                        columns = {
                            { 'kind_icon', },
                            { 'label',     'label_description', gap = 1 },
                            { 'kind' }
                        },
                    },
                    auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
                },
                -- documentation = {
                --     auto_show = true,
                --     auto_show_delay_ms = 500,
                -- },
                -- ghost_text = {
                --     enabled = true
                -- },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'snippets', 'buffer', 'path', 'dadbod' },
                providers = {
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                }
            },
            signature = {
                enabled = true,
                window = {
                    border = "single",
                    direction_priority = { 's', 'e' },
                }
            },
        },
        opts_extend = { "sources.default" }

    },

    --[[ {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
            { "L3MON4D3/LuaSnip" },
        },
    }, ]]

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            check_ts = true,
            fast_wrap = {
                map = "<M-w>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                before_key = "h",
                after_key = "l",
                cursor_pos_before = true,
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                manual_position = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        }
    },

}
