fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

client_script 'client.lua'

server_script {
    'server/module.lua',
    'server/server_save_thread.lua',
}

dependencies {
    'wx_module_system',
    'wx_player_base',
    'wx_console'
}