fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

dependencies {
    'wx_module_system',
}
client_script {
    'client/phone_viewer.lua',
}
server_script {
    'server/server_module.lua',
    'server/phone_item.lua',
}

ui_page "client/phone-ui/build/index.html"

files {
    "client/phone-ui/build/*.*",
    "client/phone-ui/build/static/js/*.*",
    "client/phone-ui/build/static/css/*.*",
    "client/phone-ui/build/static/media/*.*",
}