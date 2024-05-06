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
    vim.keymap.set("n", "<leader>cp", function()
        vim.lsp.buf.references()
    end, opts)
	vim.keymap.set("n", "<leader>cr", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>cbf", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	vim.keymap.set("n", "<leader>cwp", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>csh", function()
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

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
        "intelephense",
		"html",
		"cssls",
		"tsserver",
		"tailwindcss",
		"jsonls",
		"eslint",
		"lua_ls",
	},
	handlers = {
		lsp_zero.default_setup,
		intelephense = function()
			lspconfig.intelephense.setup({
				filetypes = { "php", "blade" },
			})
		end,
        html = function ()
            lspconfig.html.setup({
                filetypes = { "html", "templ", "php" }
            })
        end,
		--[[ emmet_language_server = function()
			lspconfig.emmet_language_server.setup({
				filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "php", "blade" },
			})
		end, ]]
	},
})

local cmp = require("cmp")
-- local cmp_action = require('lsp-zero').cmp_action()

local luasnip = require("luasnip")

luasnip.filetype_extend("php", { "html" })
luasnip.filetype_extend("blade", { "php", "html" })
luasnip.add_snippets("php", {
	luasnip.snippet("php", {
		luasnip.text_node({ "<?php " }),
		luasnip.insert_node(1),
		luasnip.text_node(" ?>"),
	}),
})
luasnip.add_snippets("php", {
	luasnip.snippet("phpe", {
		luasnip.text_node({ "<?= " }),
		luasnip.insert_node(1),
		luasnip.text_node(" ?>"),
	}),
})

require("luasnip.loaders.from_vscode").lazy_load()

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
	}, {
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
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

})
