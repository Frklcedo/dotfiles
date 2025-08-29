local ok_neorg, neorg = pcall(require, 'neorg')

if not ok_neorg then
    vim.notify("Neorg não instalado")
    return
end

vim.keymap.set("n", "<leader>nw", ":Neorg workspace notes <CR>", { desc = "Select default workspace"})
vim.keymap.set("n", "<leader>now", ":Neorg workspace ", { desc = "Select workspace "})
vim.keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)")
vim.keymap.set("n", "<leader>ntt", "<cmd>Neorg toc<CR>")


vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    callback = function()
        vim.keymap.set("n", "<leader>na", ":Neorg index <CR>")
        vim.keymap.set("n", "<leader>nlt", "<Plug>(neorg.pivot.list.toggle)", { buffer = true })
        vim.keymap.set("n", "<leader>nC", ":Neorg toggle-concealer<CR>", { buffer = true })
        vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
        vim.keymap.set("n", "<C-CR>", "<Plug>(neorg.esupports.hop.hop-link.vsplit)", { buffer = true })

        vim.keymap.set("n", "<leader>nr", ":Neorg return <CR>", { buffer = true })
        vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })

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
            vim.keymap.set("n", "<leader>nt" .. task.key, task.cmd, { buffer = true, desc = "Task to: "..task.name })
        end

        vim.keymap.set("v", "<", "<Plug>(neorg.promo.demote.range)", { buffer = true})
        vim.keymap.set("v", ">", "<Plug>(neorg.promo.promote.range)", { buffer = true } )

        vim.keymap.set("n", "<<", "<Plug>(neorg.promo.demote.nested)", { buffer = true } )
        vim.keymap.set("n", ">>", "<Plug>(neorg.promo.promote.nested)", { buffer = true } )
        vim.keymap.set("n", "<,", "<Plug>(neorg.promo.demote)", { buffer = true } )
        vim.keymap.set("n", ">.", "<Plug>(neorg.promo.promote)", { buffer = true } )

        vim.keymap.set("i", "<C-,>", "<Plug>(neorg.promo.demote)", { buffer = true } )
        vim.keymap.set("i", "<C-.>", "<Plug>(neorg.promo.promote)", { buffer = true } )

        vim.keymap.set("n", "<leader>nMc", "<Plug>(neorg.looking-glass.magnify-code-block)", { buffer = true })

        vim.keymap.set("i", "<C-CR>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })

        vim.keymap.set("n", "<leader>nm", ":Neorg inject-metadata <CR>", { buffer = true })
        vim.keymap.set("n", "<leader>ns", ":Neorg generate-workspace-summary <CR>", { buffer = true })
        vim.keymap.set("n", "<leader>nS", ":Neorg generate-workspace-summary ", { buffer = true })


    end,
})
