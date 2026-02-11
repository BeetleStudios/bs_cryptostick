# bs_cryptostick

A FiveM resource that allows players to convert crypto sticks into crypto currency at Lester's house using a hacking minigame.

## Features

- mhacking minigame integration
- Converts crypto stick items to configurable crypto amount
- Simple /crypto to check balance


## Installation

1. Place this resource in your `[standalone]` folder
2. Ensure `mhacking` resource is started (should be in `[standalone]` folder)
3. Add `ensure bs_cryptostick` to your server.cfg
4. Make sure you have a `cryptostick` item in your inventory system

## Configuration

Edit `config/shared.lua` to customize:

- `lesterHouse.coords` - Location of the laptop (default: Lester's house)
- `cryptoAmount` - Amount of crypto to give per crypto stick when using 'qbx' provider (default: 100-1000)
- `hacking.solutionLength` - Difficulty of hacking minigame (default: 4)
- `hacking.duration` - Time limit for hacking in milliseconds (default: 30000)
- `useTarget` - Use ox_target for interactions (default: true)
- `cryptoProvider` - Crypto provider to use: 'lb' for lb-phone or 'qbx' for qbx_core framework (default: 'lb')
- `lbPhone.coin` - Crypto coin type to add when using 'lb' provider (default: 'bitcoin')
- `lbPhone.amountMin` - Minimum crypto amount for 'lb' provider (default: 0.005)
- `lbPhone.amountMax` - Maximum crypto amount for 'lb' provider (default: 0.01)
- `lbPhone.amountChance` - Special chance amount for 'lb' provider (default: 0.1)

## Dependencies

- qbx_core
- ox_lib
- ox_inventory
- mhacking (standalone resource)
- ox_target (optional, if useTarget is true)
- lb-phone (required if cryptoProvider is set to 'lb')

## Usage

1. Players go to Lester's house
2. Interact with the PC
3. Complete the hacking minigame
4. Crypto stick is removed and crypto is added to their account

## Support

For support, questions, or bug reports, please join our Discord server:

[Discord Support Server](https://discord.gg/xSCBAYFwmY)
