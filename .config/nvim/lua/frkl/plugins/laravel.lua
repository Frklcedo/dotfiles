return {
    "adalessa/laravel.nvim",
    dependencies = {
        "tpope/vim-dotenv",
        "nvim-telescope/telescope.nvim",
        "MunifTanjim/nui.nvim",
        "kevinhwang91/promise-async",
    },
    -- cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    cmd = { "Laravel" },
    keys = {
        { "<leader>la", ":Laravel artisan<cr>" },
        { "<leader>lr", ":Laravel routes<cr>" },
        { "<leader>lm", ":Laravel related<cr>" },
    },
    event = { "VeryLazy" },
    opts = {
        lsp_server = "intelephense",
        features = {
            -- null_ls = {
            --     enable = true,
            -- },
            route_info = {
                enable = true,
                view = 'right', -- or right
                middlewares = true, --- wheather to show the middlewares section in the info
                method = true, --- wheather to show the method section in the info
                uri = true  --- wheather to show the uri section in the info
            },
            model_info = {
                enable = true,
            },
            override = {
                enable = true,
            },
        },
        ui = {
            default = 'popup',
            nui_opts = {
                popup = {
                    size = {
                        width = "50%",
                        height = "50%",
                    },
                    win_options = {
                        number = true,
                        relativenumber = true,
                    },

                    border = {
                        style = "double",
                    },
                    position = {
                        row = "40%",
                        col = "50%",
                    },
                }
            }
        },
        -- user_providers = {
        --     require("frkl.laravel.providers.frkl_provider"),
        -- },
    },
    config = true,
}
