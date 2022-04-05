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
    'client/client_nui.lua'
}
server_script {
    'server/server_market_callback.lua'
}

ui_page "client/market-ui/build/index.html"

files {
    "client/market-ui/build/*.*",
    "client/market-ui/build/static/js/*.*",
    "client/market-ui/build/static/css/*.*"
}