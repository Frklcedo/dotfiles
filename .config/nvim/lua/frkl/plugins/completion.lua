return {
    {
        'saghen/blink.compat',
        version = '2.*',
        lazy = true,
        opts = {},
    },
    {
        'saghen/blink.cmp',
        dependencies = {
            { 'rafamadriz/friendly-snippets' },
            { 'jsongerber/nvim-px-to-rem' },
            { "adibhanna/laravel.nvim" },
        },


        version = '1.*',

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

            appearance = {
                nerd_font_variant = 'mono'
            },

            sources = {
                default = {
                    'lsp', 'snippets', 'path', 'buffer',
                    'dadbod', 'nvim-px-to-rem',
                    'laravel'
                },
                providers = {
                    ['nvim-px-to-rem'] = { module = 'nvim-px-to-rem.integrations.blink', name = 'nvim-px-to-rem', },
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                    laravel = { name = "laravel", module = "laravel.blink_source", score_offset = 1 },
                }
            },
            snippets = { preset = 'mini_snippets' },

            completion = {
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
                    direction_priority = { 's', 'n' },
                }
            },

            cmdline = {
                keymap = {
                    preset = 'cmdline',
                    ['<C-j>'] = { 'select_next', 'fallback' },
                    ['<C-k>'] = { 'select_prev', 'fallback' },
                    -- ['<Tab>'] = { 'select_next', 'show', 'show_documentation', 'hide_documentation', 'fallback' },
                    -- ['<S-Tab>'] = { 'select_prev', 'show', 'show_documentation', 'hide_documentation', 'fallback' },
                    -- ['<C-j>'] = { 'select_next', 'fallback' },
                    -- ['<C-k>'] = { 'select_prev', 'fallback' },
                    -- ['<C-s>'] = { 'select_and_accept', 'fallback' },
                    -- ['<C-y>'] = { 'select_and_accept', 'fallback' },
                },
                completion = {
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true
                        }
                    }
                }
            },

            fuzzy = {
                sorts = {
                    function(a, b)
                        if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
                            return
                        end
                        return b.client_name == 'emmet_language_server'
                    end,
                    'score',
                    'sort_text',
                }
            }

        },
        opts_extend = { "sources.default" }

    },
    {
        'jsongerber/nvim-px-to-rem',
        opts = {
            filetypes = {
                "css",
                "scss",
                "sass",
                "vue",
                "php",
            },
        }
    }

}
