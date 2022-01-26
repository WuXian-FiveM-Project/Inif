fx_version 'cerulean'
game 'common'

name 'oxmysql'
description 'Database wrapper for FiveM utilising node-mysql2 offering improved performance and security.'
version '1.9.2'
url 'https://github.com/overextended/oxmysql'
author 'overextended'

dependencies {
	'wx_module_system',
	'wx_console'
}
server_scripts {
	'module.lua',
	'config.lua',
	'lib/module.lua',
	'dist/server/build.js',
}