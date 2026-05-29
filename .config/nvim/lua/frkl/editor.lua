vim.api.nvim_create_autocmd("PackChanged", {
    callback = function (ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end
})

return {
	"https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	"https://github.com/numtostr/comment.nvim",
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
}
