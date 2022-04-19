fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

server_script {
    'server/server.lua',
}
client_script {
    'client/phone.lua',
}
dependencies {
    'wx_module_system',
    'wx_mysql_linker',
}