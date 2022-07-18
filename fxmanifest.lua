fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'VORP edit by @outsider'
lua54 'yes'
description 'Bank system VORP'

client_scripts {
	'config.lua',
	'client/*.lua',
	'languages/*.lua',
	'locale.lua'
}

server_scripts {
	'server/*.lua'
}


--dont touch
--version '1.3'
--vorp_checker 'yes'
--vorp_name '^4Resource version Check^3'
--vorp_github 'https://github.com/VORPCORE/vorp_bandits'
