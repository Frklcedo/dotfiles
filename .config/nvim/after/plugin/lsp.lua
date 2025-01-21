vim.opt.signcolumn = 'yes'

local lspconfig = require("lspconfig")

local blinkcmp = require('blink.cmp')

local lspconfig_defaults = lspconfig.util.default_config
-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
--     'force',
--     lspconfig_defaults.capabilities
--     -- require('cmp_nvim_lsp').default_capabilities()
-- )
lspconfig_defaults.capabilities = blinkcmp.get_lsp_capabilities(lspconfig_defaults.capabilities)

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf, remap = false }

        vim.keymap.set("n", "<leader>ch", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("i", "<M-h>", function()
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
    end
})

local function phproot_dir(pattern, ...)
    local util = require("lspconfig.util")
    local cwd = vim.loop.cwd()
    local root = util.root_pattern(...)(pattern)

    -- prefer cwd if root is a descendant
    return util.path.is_descendant(cwd, root) and cwd or root
end

lspconfig.phpactor.setup({
    filetypes = { "php", "blade" },
    root_dir = function(pattern)
        return phproot_dir(pattern, 'composer.json', '.git', '.phpactor.json', '.phpactor.yml',
            'wp-config.php')
    end,
})

local node_version = "v22.13.0"
local npm_path = vim.env.HOME .. '/.config/nvm/versions/node/' .. node_version .. '/lib'

lspconfig.ts_ls.setup({
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = npm_path .. "/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
            },
        }
    },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
})

lspconfig.volar.setup({
    init_options = {
        typescript = {
            tsdk = npm_path .. '/node_modules/typescript/lib'
        }
    }
})

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        -- "intelephense",
        -- "phpactor",
        -- "ts_ls",
        -- "volar",
        "html",
        "cssls",
        "tailwindcss",
        "jsonls",
        "lua_ls",
        "emmet_language_server",
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
        phpactor = function() end,
        ts_ls = function() end,
        volar = function() end,
        intelephense = function()
            lspconfig.intelephense.setup({
                filetypes = { "php", "blade" },
                root_dir = function(pattern)
                    return phproot_dir(pattern, 'composer.json', '.git', 'wp-config.php')
                end,
            })
        end,
        emmet_language_server = function()
            lspconfig.emmet_language_server.setup({
                filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "php", "blade", "vue" },
            })
        end,
        html = function()
            lspconfig.html.setup({
                filetypes = { "html", "templ", "php", "vue", "blade" }
            })
        end,
        lua_ls = function()
            lspconfig.lua_ls.setup {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            }
        end
    },
})
