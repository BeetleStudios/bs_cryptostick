local config = require 'config.shared'

---@param src number
---@return boolean
local function isPlayerAtLesterHouse(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local distance = #(playerCoords - config.lesterHouse.coords)
    return distance <= 5.0
end

---@param src number
---@return boolean success
---@return number amount
local function addCryptoToPlayer(src)
    if config.cryptoProvider == 'lb' then
        -- Use lb-phone
        local lbPhoneResource = GetResourceState('lb-phone')
        if lbPhoneResource ~= 'started' then
            return false, 0
        end
        
        local amount
        if math.random(1, 100) < 2 then
            amount = config.lbPhone.amountChance
        else
            amount = math.random() * (config.lbPhone.amountMax - config.lbPhone.amountMin) + config.lbPhone.amountMin
        end
        
        local success = exports['lb-phone']:AddCrypto(src, config.lbPhone.coin, amount)
        if success then
            return true, amount
        end
        return false, 0
    else
        -- Use qbx_core framework
        local Player = exports.qbx_core:GetPlayer(src)
        if not Player then
            return false, 0
        end
        
        local amount = math.random(config.cryptoAmount.min, config.cryptoAmount.max)
        Player.Functions.AddMoney('crypto', amount, 'crypto_stick_conversion')
        return true, amount
    end
end

-- Check if player has crypto stick and is at Lester's house
RegisterNetEvent('bs_cryptostick:server:checkItem', function()
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
    TriggerClientEvent('bs_cryptostick:client:startHacking', src)
end)

-- Convert crypto stick to crypto after successful hack
RegisterNetEvent('bs_cryptostick:server:convertCrypto', function()
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
    local success, cryptoAmount = addCryptoToPlayer(src)
    
    if not success then
        exports.qbx_core:Notify(src, locale('error.crypto_add_failed'), 'error')
        -- Give the item back if crypto add failed
        Player.Functions.AddItem(config.requiredItem, 1)
        return
    end
    
    exports.qbx_core:Notify(src, locale('success.converted', cryptoAmount), 'success')
    TriggerClientEvent('inventory:client:ItemBox', src, exports.ox_inventory:Items()[config.requiredItem], 'remove')
end)

-- Command to check crypto balance (only available when using qbx provider)
if config.cryptoProvider == 'qbx' then
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
end
