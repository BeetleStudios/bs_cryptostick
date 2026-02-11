return {
    -- Lester's house location (where the pc is)
    lesterHouse = {
        coords = vector3(1275.58, -1710.48, 54.77),
        size = vector3(2, 2, 1.0),
        heading = 302.17,
        debugPoly = false,
        distance = 2.0
    },
    
    -- Item required for conversion
    requiredItem = 'cryptostick',
    
    -- Crypto amount to give per crypto stick (configurable)
    cryptoAmount = {
        min = 100,
        max = 1000,
        chance = 10000
    },
    
    -- Hacking minigame settings
    hacking = {
        solutionLength = 4, -- Length of the solution code
        duration = 30000 -- Duration in milliseconds (30 seconds)
    },
    
    -- Use ox_target for interactions (set to false to use lib.zones)
    useTarget = true,
    
    -- Crypto provider: 'lb' for lb-phone, 'qbx' for qbx_core framework
    cryptoProvider = 'lb',
    
    -- lb-phone settings (only used if cryptoProvider is 'lb')
    lbPhone = {
        coin = 'bitcoin', -- Crypto coin type to add (e.g., 'bitcoin', 'ethereum', 'dogecoin', etc.)
        amountMin = .005,
        amountMax = .01,
        amountChance = .1
    }
}
