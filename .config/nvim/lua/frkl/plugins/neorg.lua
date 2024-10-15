vim.keymap.set("n", "<leader>N", ":Neorg <CR>")
vim.keymap.set("n", "<leader>nn", ":Neorg index<CR>")
vim.keymap.set("n", "<leader>nw", ":Neorg workspace ")
vim.keymap.set("n", "<leader><C-n>", ":Neorg workspace<CR>")
vim.keymap.set("n", "<leader>nc", "<Plug>(neorg.dirman.new-note)")
vim.keymap.set("n", "<leader>nv", ":Neorg toggle-concealer<CR>", { buffer = true } )

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    callback = function()
        vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })
        vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
        vim.keymap.set("n", "<leader>nr", ":Neorg return <CR>", { buffer = true })

        local tasks = {
            { key = "d", cmd = "<Plug>(neorg.qol.todo-items.todo.task-done)",       name = "Tarefa feita"       },
            { key = "u", cmd = "<Plug>(neorg.qol.todo-items.todo.task-undone)",     name = "Tarefa a fazer"     },
            { key = "p", cmd = "<Plug>(neorg.qol.todo-items.todo.task-pending)",    name = "Tarefa pendente"    },
            { key = "a", cmd = "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)",  name = "Tarefa ambígua"     },
            { key = "c", cmd = "<Plug>(neorg.qol.todo-items.todo.task-cancelled)",  name = "Tarefa cancelada"   },
            { key = "h", cmd = "<Plug>(neorg.qol.todo-items.todo.task-on-hold)",    name = "Tarefa em espera"   },
            { key = "i", cmd = "<Plug>(neorg.qol.todo-items.todo.task-important)",  name = "Tarefa importante"  },
            { key = "r", cmd = "<Plug>(neorg.qol.todo-items.todo.task-recurring)",  name = "Tarefa recorrente"  },
        }
        for _, task in ipairs(tasks) do
            vim.keymap.set("n", "<leader>nt" .. task.key, task.cmd, { buffer = true })
        end
        vim.keymap.set("n", "<leader>ntt", function ()
            local message = "Estados de tarefas:\n"
            for _, task in ipairs(tasks) do
                message = message .. string.format("<leader>nt%s => %s\n", task.key, task.name)
            end

            vim.notify(message, vim.log.levels.INFO, {
                title = 'Tarefas Disponíveis',
                timeout = 5000,
            })
        end, { buffer = true })

        vim.keymap.set("v", "<", "<Plug>(neorg.promo.demote.range)", { buffer = true})
        vim.keymap.set("v", ">", "<Plug>(neorg.promo.promote.range)", { buffer = true } )

        vim.keymap.set("n", "<<", "<Plug>(neorg.promo.demote)", { buffer = true } )
        vim.keymap.set("n", ">>", "<Plug>(neorg.promo.promote)", { buffer = true } )

        vim.keymap.set("n", "<Space", "<Plug>(neorg.promo.demote.nested)", { buffer = true } )
        vim.keymap.set("n", ">Space", "<Plug>(neorg.promo.promote.nested)", { buffer = true } )

        vim.keymap.set("n", "<localleader>nl", "<Plug>(neorg.pivot.list.toggle)", { buffer = true } )


    end,
})

return {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function ()
        local neorg = require("neorg")
        neorg.setup({
            load = {
                ["core.defaults"] = {},
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = false
                    }
                },
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond"
                    }
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes"
                        },
                        default_workspace = "notes",
                        index = "index.norg",
                    }
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp"
                    }
                },
            }
        })
    end,
}
