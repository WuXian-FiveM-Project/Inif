fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

dependencies {
    'wx_module_system',
}
client_script {
    'client/client_app_module.lua',
    'client/phone_viewer.lua',
}
server_script {
    'server/app_module.lua',
    'server/server_module.lua',
    'server/phone_item.lua',
}

ui_page "client/phone-ui/build/index.html"