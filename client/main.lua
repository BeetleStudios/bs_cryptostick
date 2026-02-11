local config = require 'config.shared'
local isHacking = false
local zoneCreated = false

---@param coords vector3
---@param size vector3
---@param heading number
local function createLaptopZone(coords, size, heading)
    if zoneCreated then return end
    
    if config.useTarget then
        local zoneId = exports.ox_target:addBoxZone({
            name = 'bs_cryptostick_laptop',
            coords = coords,
            size = size,
            rotation = heading,
            debug = config.lesterHouse.debugPoly,
            options = {
                {
                    name = 'bs_cryptostick_laptop_interact',
                    icon = 'fas fa-laptop',
                    label = locale('info.use_laptop'),
                    distance = config.lesterHouse.distance,
                    canInteract = function()
                        if isHacking then
                            return false
                        end
                        return true
                    end,
                    onSelect = function()
                        TriggerServerEvent('bs_cryptostick:server:checkItem')
                    end
                }
            }
        })
        zoneCreated = true
    else
        lib.zones.box({
            name = 'bs_cryptostick_laptop',
            coords = coords,
            size = size,
            rotation = heading,
            debug = config.lesterHouse.debugPoly,
            onEnter = function()
                if not isHacking then
                    lib.showTextUI(locale('info.use_laptop'))
                end
            end,
            onExit = function()
                lib.hideTextUI()
            end,
            inside = function()
                if IsControlJustPressed(0, 38) and not isHacking then -- E key
                    lib.hideTextUI()
                    TriggerServerEvent('bs_cryptostick:server:checkItem')
                end
            end
        })
        zoneCreated = true
    end
end

-- Initialize the laptop zone after player is ready
CreateThread(function()
    -- Wait for player to be logged in
    while not LocalPlayer.state.isLoggedIn do
        Wait(1000)
    end
    
    -- Wait a bit more to ensure everything is loaded
    Wait(2000)
    
    createLaptopZone(
        config.lesterHouse.coords,
        config.lesterHouse.size,
        config.lesterHouse.heading
    )
end)

-- Start hacking minigame
RegisterNetEvent('bs_cryptostick:client:startHacking', function()
    if isHacking then
        return
    end

    isHacking = true
    
    -- Start the mhacking minigame
    TriggerEvent('mhacking:show')
    TriggerEvent('mhacking:start', config.hacking.solutionLength, config.hacking.duration, function(success, remainingTime)
        TriggerEvent('mhacking:hide')
        isHacking = false
        
        if success then
            -- Notify server that hacking was successful
            TriggerServerEvent('bs_cryptostick:server:convertCrypto')
        else
            exports.qbx_core:Notify(locale('error.hacking_failed'), 'error')
        end
    end)
end)
