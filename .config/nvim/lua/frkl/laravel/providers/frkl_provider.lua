local frkl_provider = {}

function frkl_provider:register(app)
end

function frkl_provider:boot(app)
    local route_info_view = {}

    function route_info_view:get(route)
        return {
            virt_text = {
                { "[",                              "comment" },
                { "Name: ",                         "comment" },
                { route.name,                       "@enum" },
                { " Uri: ",                         "comment" },
                { route.uri,                        "@enum" },
                { " Method: ",                      "comment" },
                { table.concat(route.methods, "|"), "@enum" },
                { "]",                              "comment" },
            },
        }
    end

    app:instance("route_info_view", route_info_view)

    -- app("cache_views_repository"):all():thenCall(function(views)
    --     vim.print(views)
    -- end)
end

return frkl_provider
