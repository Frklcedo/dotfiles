local miniSnippets = require('mini.snippets')
local gen_loader = miniSnippets.gen_loader


local function expand_snippet(lang, new_pattern)
    return { lang .. '/**/*.json', lang .. '/**/*.lua', '**/' .. lang .. '.json', '**/' .. lang .. '.lua', new_pattern }
end

local vue_pattern = '**/vue/**/*.json'
local blade_pattern = '**/blade/**/*.json'

miniSnippets.setup({
    snippets = {
        gen_loader.from_lang({
            lang_patterns = {
                vue = expand_snippet('vue', vue_pattern),
                typescript = expand_snippet('typescript', vue_pattern),
                javascript = expand_snippet('javascript', vue_pattern),
                blade = expand_snippet('blade', blade_pattern),
            },
        }),
        gen_loader.from_file('~/.config/nvim/snippets/global.json'),
    },
    mappings = {
        stop = '<C-e>',
        expand = '<M-s>'
    },
})
