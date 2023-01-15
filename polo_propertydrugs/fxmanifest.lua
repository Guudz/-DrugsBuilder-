fx_version 'adamant'

game 'gta5'
lua54 'yes'
description 'Polo Drugs Builder'

version 'legacy'

shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'*.lua',
	'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'*.lua',
	'client/*.lua'
}

dependencies {
	'async',
	'es_extended',
	'instance',
	'ox_lib',
	'cron',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore'
}
