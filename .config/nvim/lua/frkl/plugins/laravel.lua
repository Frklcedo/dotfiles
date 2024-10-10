return {
    "adalessa/laravel.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
        { "<leader>la", ":Laravel artisan<cr>" },
        { "<leader>lm", ":Laravel related<cr>" },
    },
    event = { "VeryLazy" },
    opts = {
        lsp_server = "intelephense",
        features = {
            null_ls = {
                enable = true,
            },
            route_info = {
                enable = true, --- to enable the laravel.nvim virtual text
                position = 'right', --- where to show the info (available options 'right', 'top')
                middlewares = true, --- wheather to show the middlewares section in the info
                method = true, --- wheather to show the method section in the info
                uri = true  --- wheather to show the uri section in the info
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
        }
    },
    config = true,
}
