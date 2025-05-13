return {
    {
        'saghen/blink.cmp',
        dependencies = {
            -- {
            --     "L3MON4D3/LuaSnip",
            --     version = "v2.*",
            --     build = "make install_jsregexp",
            --     dependencies = { "rafamadriz/friendly-snippets" },
            -- },
            { 'rafamadriz/friendly-snippets' },
            { 'jsongerber/nvim-px-to-rem' },
        },


        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = {
                    'nvim-px-to-rem',
                    'lsp',
                    'snippets',
                    'buffer',
                    'path',
                    'dadbod'
                },
                providers = {
                    ['nvim-px-to-rem'] = { module = 'nvim-px-to-rem.integrations.blink', name = 'nvim-px-to-rem', },
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                }
            },
            -- snippets = { preset = 'luasnip' },

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

            cmdline = {
                keymap = {
                    preset = 'default',
                    ['<Tab>'] = { 'select_next', 'show', 'show_documentation', 'hide_documentation', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'show', 'show_documentation', 'hide_documentation', 'fallback' },
                    ['<C-j>'] = { 'select_next', 'fallback' },
                    ['<C-k>'] = { 'select_prev', 'fallback' },
                    ['<C-s>'] = { 'select_and_accept', 'fallback' },
                    ['<C-y>'] = { 'select_and_accept', 'fallback' },
                }
            },

            completion = {
                -- list = { selection = function (ctx) return ctx.mode == 'cmdline' and 'auto_insert' or "manual" end },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false
                    }
                },
                keyword = {
                    range = 'prefix',
                    -- regex = '[-_]\\|\\k\\|\\$',
                },
                trigger = {
                    show_on_trigger_character = false
                },
                menu = {
                    draw = {
                        columns = {
                            { 'label',     'label_description', gap = 1 },
                            { 'kind_icon', },
                            { 'kind' },
                        },
                    },
                    auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
                },
                documentation = {
                    auto_show = true,
                    -- auto_show_delay_ms = 500,
                },
                -- ghost_text = {
                --     enabled = true
                -- },
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
    --
    -- {
    --     "L3MON4D3/LuaSnip",
    --     version = "v2.*",
    --     build = "make install_jsregexp",
    --     dependencies = { "rafamadriz/friendly-snippets" },
    -- },

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
    {
    'jsongerber/nvim-px-to-rem',
    config = function()
        require('nvim-px-to-rem').setup({
            filetypes = {
                "css",
                "scss",
                "sass",
                "vue",
                "php",
            },
        })
    end,
    }


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

}
