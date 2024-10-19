-- local telescope = require("telescope")
-- local opts = {}
--
-- vim.keymap.set("n", "<leader>lr", function ()
--     telescope.extensions.laravel.routes({
--         layout_strategy = 'vertical',
--     })
-- end, opts)
-- vim.keymap.set("n", "<leader>la", function ()
--     telescope.extensions.laravel.artisan({
--         layout_strategy = 'vertical',
--     })
-- end, opts)

local app = require("laravel").app

local route_info_view = {}

function route_info_view:get(route)
      return {
        virt_text = {
            { "[",                              "comment" },
            { "Name: ",                         "comment" },
            { route.name,                       "@enum" },
            { " Method: ",                      "comment" },
            { table.concat(route.methods, "|"), "@enum" },
            { " Uri: ",                         "comment" },
            { route.uri,                        "@enum" },
            { "]",                              "comment" },
        },
      }
end

app:instance("route_info_view", route_info_view)

