fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

dependencies {
    'wx_module_system',
    'wx_render',
    'wx_callback'
}
client_script 'client.lua'

server_script 'server.lua'

ui_page 'garage-ui/build/index.html'

files {
    "garage-ui/build/*.*",
    "garage-ui/build/static/css/*.*",
    "garage-ui/build/static/js/*.*",
    "garage-ui/build/static/media/*.*",
}