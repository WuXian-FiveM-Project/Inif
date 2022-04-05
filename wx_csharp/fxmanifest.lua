-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'John Doe <j.doe@example.com>'
description 'Example resource'
version '1.0.0'

-- What to run
client_scripts {
    'client.cs',
}
server_script 'server.lua'