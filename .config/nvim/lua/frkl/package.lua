local build = {}

build.telescope_fzf = function (path, kind) 
    if kind ~= 'install' and kind ~= 'update' then
        return
    end

    local result = vim.system({ 'make' }, { cwd = path }):wait()
    if result.code ~= 0 then
        vim.notify("telescope-fzf-native build failed:\n" .. result.stderr, vim.log.levels.ERROR)
        return
    end
    vim.notify("telescope-fzf-native compiled!", vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function (ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'telescope-fzf-native.nvim' then
            build.telescope_fzf(ev.data.path, kind)
        end
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end
})

vim.pack.add(require("frkl.plugins"))

vim.g.suda_smart_edit = 1
