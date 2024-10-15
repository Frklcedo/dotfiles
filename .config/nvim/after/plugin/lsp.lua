local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>ch", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>cd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>cP", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>cr", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>cf", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<leader>csq", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>chh", function()
        vim.lsp.buf.signature_help()
    end, opts)

    vim.keymap.set("n", "<leader>of", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>cgp", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>cgn", function()
        vim.diagnostic.goto_next()
    end, opts)
end)

local volar_tsplugin = vim.fn.expand(
    '$HOME/.nvm/versions/node/v20.15.0/lib/node_modules/@vue/typescript-plugin')

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "intelephense",
        -- "phpactor",
        "html",
        "cssls",
        "ts_ls",
        "tailwindcss",
        "jsonls",
        "eslint",
        "lua_ls",
        "volar",
        "emmet_language_server",
    },
    handlers = {
        lsp_zero.default_setup,
        intelephense = function()
            lspconfig.intelephense.setup({
                filetypes = { "php", "blade" },
            })
        end,
        phpactor = function()
            lspconfig.phpactor.setup({
                filetypes = { "php", "blade" },
            })
        end,
        html = function()
            lspconfig.html.setup({
                filetypes = { "html", "templ", "php", "vue", "blade" }
            })
        end,
        emmet_language_server = function()
            lspconfig.emmet_language_server.setup({
                filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "php", "blade", "vue" },
            })
        end,
        ts_ls = function()
            lspconfig.ts_ls.setup({
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = volar_tsplugin,
                            languages = { "javascript", "typescript", "vue" },
                        },
                    }
                },
                filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
            })
        end,
    },
})
