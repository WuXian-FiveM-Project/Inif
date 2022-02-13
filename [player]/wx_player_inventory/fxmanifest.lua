fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

server_script {
    'server/server.lua',
    'server/drop_route.lua'
}
client_script {
    'client/drop_route.lua'
}
dependencies {
    'wx_module_system',
    'wx_console',
    'wx_player_base'
}