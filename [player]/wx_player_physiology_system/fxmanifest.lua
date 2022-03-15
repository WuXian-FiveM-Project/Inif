fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

server_script 'server.lua'
client_script {
    'client.lua',
    'physiologyMenu.lua'
}

dependencies {
    'wx_module_system',
    'wx_player_base',
    'wx_callback'
}

ui_page 'physiology-system-ui/build/index.html'

files {
    "physiology-system-ui/build/index.html",
    "physiology-system-ui/build/static/js/*.*",
    "physiology-system-ui/build/static/css/*.*",
}