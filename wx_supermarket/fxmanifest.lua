fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

dependencies {
    'wx_module_system',
    'wx_render'
}
client_script {
    'client/create_market.lua',
}
server_script 'server.lua'