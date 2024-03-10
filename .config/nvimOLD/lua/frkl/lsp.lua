local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	-- lsp_zero.default_keymaps({buffer = bufnr})
	local opts = { buffer = bufnr, remap = false }

	-- keybindings
	vim.keymap.set("n", "<leader>cd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>ch", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>cr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>cR", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	vim.keymap.set("n", "<leader>cdd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "<leader>cdh", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>cdl", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)

	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"html",
		"cssls",
		"tsserver",
		"tailwindcss",
		"jsonls",
		"eslint",
		"lua_ls",
		"sqlls",
		"vuels",
	},
	handlers = {
		lsp_zero.default_setup,
		phpactor = function()
			lspconfig.phpactor.setup({
				filetypes = { "php", "blade" },
				settings = {},
			})
		end,
		emmet_language_server = function()
			lspconfig.emmet_language_server.setup({
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
					"php",
					"blade",
				},
			})
		end,
	},
})

-- lsp_zero.nvim_workspace()

local cmp = require("cmp")
local luasnip = require("luasnip")
local autopairs = require("nvim-autopairs")

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

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	Text = "󰊄",
	Method = "m",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "󰫧",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "󰌆",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "󰉺",
}

autopairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		php = { "string", "template_string" },
		blade = { "string", "template_string" },
	},
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
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

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
		-- ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
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
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[Lsp]",
				nvim_lua = "[Lua]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.g.user_emmet_leader_key = "<M-,>"
