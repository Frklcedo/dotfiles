local vue_language_server_path = vim.fn.system("npm root -g"):gsub("%s+$", "") .. "/@vue/language-server"

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
