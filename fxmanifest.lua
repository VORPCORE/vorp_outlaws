fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'VORP @outsider'
lua54 'yes'
description 'A Npc outlaw ambush scrip for vorp core framework'
repository 'https://github.com/VORPCORE/vorp_outlaws'

shared_scripts {
	'config.lua',
	'locale.lua',
	'languages/*.lua'
}
client_script 'client/*.lua'
server_script 'server/*.lua'



--dont touch
version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_outlaws'
