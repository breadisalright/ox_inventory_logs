types = {}

function addTypeHook(name, from, to, callback)
    types[name] = {
        from = from,
        to = to,
        callback = callback
    }
end
    exports.ox_inventory:registerHook(
        'swapItems',
        function(payload)
            for name, data in pairs(types) do
                if payload.fromType == data.from and payload.toType == data.to then
                    data.callback(payload)
                end
            end
        end,
        options
    )
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if GetResourceState('ox_inventory') ~= 'started' then return end
    exports.ox_inventory:removeHooks()
end)
