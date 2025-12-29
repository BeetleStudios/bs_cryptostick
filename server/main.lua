local config = require 'config.shared'

---@param src number
---@return boolean
local function isPlayerAtLesterHouse(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local distance = #(playerCoords - config.lesterHouse.coords)
    return distance <= 5.0
end

-- Check if player has crypto stick and is at Lester's house
RegisterNetEvent('ns-cryptostick:server:checkItem', function()
    local src = source
    
    -- Verify player is at Lester's house
    if not isPlayerAtLesterHouse(src) then
        exports.qbx_core:Notify(src, locale('error.not_at_location'), 'error')
        return
    end
    
    -- Check if player has crypto stick
    local hasItem = exports.ox_inventory:GetItemCount(src, config.requiredItem) or 0
    
    if hasItem < 1 then
        exports.qbx_core:Notify(src, locale('error.no_crypto_stick'), 'error')
        return
    end
    
    -- Start hacking minigame on client
    TriggerClientEvent('ns-cryptostick:client:startHacking', src)
end)

-- Convert crypto stick to crypto after successful hack
RegisterNetEvent('ns-cryptostick:server:convertCrypto', function()
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    
    if not Player then
        exports.qbx_core:Notify(src, locale('error.player_not_found'), 'error')
        return
    end
    
    -- Verify player is still at Lester's house
    if not isPlayerAtLesterHouse(src) then
        exports.qbx_core:Notify(src, locale('error.not_at_location'), 'error')
        return
    end
    
    -- Remove crypto stick using Qbox Player object
    if not Player.Functions.RemoveItem(config.requiredItem, 1) then
        exports.qbx_core:Notify(src, locale('error.no_crypto_stick'), 'error')
        return
    end
    
    -- Add crypto to player
    Player.Functions.AddMoney('crypto', math.random(config.cryptoAmount.min, config.cryptoAmount.max), 'crypto_stick_conversion')
    exports.qbx_core:Notify(src, locale('success.converted', config.cryptoAmount), 'success')
    TriggerClientEvent('inventory:client:ItemBox', src, exports.ox_inventory:Items()[config.requiredItem], 'remove')
end)

-- Command to check crypto balance
lib.addCommand('crypto', {
    help = 'Check your crypto balance',
}, function(source)
    local Player = exports.qbx_core:GetPlayer(source)
    
    if not Player then
        exports.qbx_core:Notify(source, locale('error.player_not_found'), 'error')
        return
    end
    
    local cryptoBalance = Player.Functions.GetMoney('crypto') or 0
    exports.qbx_core:Notify(source, string.format('Your crypto balance: $%s', cryptoBalance), 'primary')
end)

