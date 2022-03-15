fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

server_script 'server.lua'
client_script 'client.lua'

dependencies {
    'wx_module_system',
    'wx_player_base',
}

ui_page "notify-nui/build/index.html"

files {
    "notify-nui/",
    "notify-nui/build/",
    "notify-nui/build/index.html",
    "notify-nui/build/*.*",
    "notify-nui/build/static/js/*.*",
    "notify-nui/build/static/css/*.*",
}