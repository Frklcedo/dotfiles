local lsp_attach_callback = function(event)
	local opts = { buffer = event.buf, remap = false }

	vim.keymap.set("n", "<leader>ch", function()
		vim.lsp.buf.hover()
	end, with_desc(opts, "Lsp actions: Display symbol information"))

	vim.keymap.set("i", "<M-i>", function()
		vim.lsp.buf.hover()
	end, with_desc(opts, "Lsp actions: Display symbol information"))

	vim.keymap.set("n", "<leader>cd", function()
		vim.lsp.buf.definition()
	end, with_desc(opts, "Lsp actions: Goto Definition"))

	vim.keymap.set("n", "<leader>cp", function()
		vim.lsp.buf.references()
	end, with_desc(opts, "Lsp actions: List symbol references"))

	vim.keymap.set("n", "<leader>cr", function()
		vim.lsp.buf.rename()
	end, with_desc(opts, "Lsp actions: Rename all symbol references"))

	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, with_desc(opts, "Lsp actions: Select code action"))

	vim.keymap.set("n", "<leader>cqq", function()
		vim.lsp.buf.workspace_symbol()
	end, with_desc(opts, "Lsp actions: Search by grep workspace symbol"))

	vim.keymap.set("n", "<leader>cs", function()
		vim.lsp.buf.signature_help()
	end, with_desc(opts, "Lsp actions: Display symbol signature help"))

	vim.keymap.set("i", "<C-s>", function()
		vim.lsp.buf.signature_help()
	end, with_desc(opts, "Lsp actions: Display symbol signature help"))

	vim.keymap.set("n", "<leader>cw", function()
		vim.diagnostic.open_float()
	end, with_desc(opts, "Lsp actions: Display diagnostic"))

	vim.keymap.set("n", "<leader>cqw", function()
		vim.diagnostic.setqflist()
	end, with_desc(opts, "Lsp actions: Show diagnostics list"))

	vim.keymap.set("n", "<leader>cf", function()
		local conform_ok, conform = pcall(require, "conform")
		if conform_ok then
			conform.format({ async = true })
		else
			vim.lsp.buf.format({ async = true })
		end
	end, with_desc(opts, "Lsp actions: Format buffer"))

end

vim.lsp.enable("phpactor")
vim.lsp.enable({ "vtsls", "vue_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Lsp actions",
	callback = lsp_attach_callback,
})
