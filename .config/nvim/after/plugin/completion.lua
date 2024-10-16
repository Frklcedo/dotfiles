local status_ls, ls = pcall(require, "luasnip")
local status_cmp, cmp = pcall(require, "cmp")

if not status_ls or not status_cmp then
	vim.notify("completion not found!")
end

local types = require("cmp.types")

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

require("luasnip.loaders.from_vscode").lazy_load()

local function deprioritize_snippet(entry1, entry2)
    if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
    if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
end

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
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
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif ls.expandable() then
                ls.expand()
            elseif ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s", }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sorting = {
        priority_weight = 1,
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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup.filetype({ "sql", "mysql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    }
})


