return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local ls = require("luasnip")
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node

            ls.filetype_extend("php", { "html" })
            ls.filetype_extend("blade", { "php", "html" })
            ls.add_snippets("php", {
                s("php", {
                    t({ "<?php " }),
                    i(1),
                    t(" ?>"),
                }),
            })
            ls.add_snippets("php", {
                s("phpe", {
                    t({ "<?= " }),
                    i(1),
                    t(" ?>"),
                }),
            })
        end
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
        },
        config = function()
            local cmp = require("cmp")
            local types = require("cmp.types")

            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            local function deprioritize_snippet(entry1, entry2)
                if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
                if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
            end


            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "path" },
                }, {
                    { name = "neorg" },
                }),

                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        deprioritize_snippet,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        -- cmp.config.compare.scopes,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        -- cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            })

            cmp.setup.filetype({ "sql" }, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                }
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
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
                            filetypes = { "html", "templ", "php", "vue" }
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
        end
    },

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
        "brenoprata10/nvim-highlight-colors",
        opts = {}
    },

}
