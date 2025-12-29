# ns-cryptostick

A FiveM resource that allows players to convert crypto sticks into crypto currency at Lester's house using a hacking minigame.

## Features

- mhacking minigame integration
- Converts crypto stick items to configurable crypto amount
- Simple /crypto to check balance


## Installation

1. Place this resource in your `[standalone]` folder
2. Ensure `mhacking` resource is started (should be in `[standalone]` folder)
3. Add `ensure ns-cryptostick` to your server.cfg
4. Make sure you have a `cryptostick` item in your inventory system

## Configuration

Edit `config/shared.lua` to customize:

- `lesterHouse.coords` - Location of the laptop (default: Lester's house)
- `cryptoAmount` - Amount of crypto to give per crypto stick (default: 100)
- `hacking.solutionLength` - Difficulty of hacking minigame (default: 4)
- `hacking.duration` - Time limit for hacking in milliseconds (default: 30000)
- `useTarget` - Use ox_target for interactions (default: true)

## Dependencies

- qbx_core
- ox_lib
- ox_inventory
- mhacking (standalone resource)
- ox_target (optional, if useTarget is true)

## Usage

1. Players go to Lester's house
2. Interact with the laptop
3. Complete the hacking minigame
4. Crypto stick is removed and crypto is added to their account

## License

GPL-3.0

