return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    -- dependencies = { { "benlubas/neorg-interim-ls" } },
    config = true,
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = {
                    icon_preset = "diamond"
                }
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                    default_workspace = "notes",
                }
            },
            ["core.itero"] = {},
            ["core.summary"] = {},
            ["core.export"] = {},
            ["core.keybinds"] = {
                config = {
                    default_keybinds = false,
                },
            },
            -- ["core.completion"] = {
            --     config = {
            --         engine = { module_name = "nvim-cmp" },
            --         name = "neorg"
            --     }
            -- },
            -- ["external.interim-ls"] = {}
        }
    }
}
