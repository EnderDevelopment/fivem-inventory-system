local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.TriggerServerCallback('inventory:getInventory', function(inventory)
        -- Handle inventory data
    end)
end)

function OpenInventory()
    ESX.TriggerServerCallback('inventory:getInventory', function(inventory)
        -- Open inventory UI
    end)
end

RegisterCommand('inventory', function()
    OpenInventory()
end, false)