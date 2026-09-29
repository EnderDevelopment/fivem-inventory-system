local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('inventory:getInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT items FROM player_inventory WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result then
            cb(json.decode(result))
        else
            local defaultItems = Config.DefaultItems
            MySQL.Async.execute('INSERT INTO player_inventory (identifier, items) VALUES (@identifier, @items)', {
                ['@identifier'] = identifier,
                ['@items'] = json.encode(defaultItems)
            })
            cb(defaultItems)
        end
    end)
end)

ESX.RegisterServerCallback('inventory:updateInventory', function(source, cb, items)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('UPDATE player_inventory SET items = @items WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['@items'] = json.encode(items)
    }, function()
        cb(true)
    end)
end)