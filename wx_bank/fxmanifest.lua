fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

client_script {
    'client/*.lua',
}
server_script {
    'server/*.lua',
}
dependencies {
    'wx_module_system',
    'wx_console'
}

ui_page "bank-ui/build/index.html"

files {
    "bank-ui/build/*.*",
    "bank-ui/build/static/*.*",
    "bank-ui/build/static/css/*.*",
    "bank-ui/build/static/js/*.*",
}