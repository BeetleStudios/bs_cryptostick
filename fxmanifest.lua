fx_version 'cerulean'
game 'gta5'

description 'bs_cryptostick - Convert crypto sticks to crypto'
repository 'https://github.com/your-repo/bs_cryptostick'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
}

client_script 'client/main.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

files {
    'config/shared.lua',
    'locales/*.json'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'

ox_lib 'locale'
