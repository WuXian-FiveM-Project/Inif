fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

dependencies {
    'wx_module_system',
    'wx_player_inventory',
}
client_script 'client.lua'
server_script 'server.lua'
shared_script 'shared.lua'

ui_page "react-front/build/index.html"

files {
    "react-front/build/*.*",
    "react-front/build/static/js/*.*"
}