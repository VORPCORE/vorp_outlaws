Config = {}

Config.Cooldown = 540000 -- 9 minutes

Config.Outlaws = {

	firstLocation = {
		Random = { min = 1, max = 1 }, -- set between min and max how lucky a player will be to trigger an ambush
		luckynumber = 1, -- if the random number = this number then start ambush
		CheckLuckyNumber = 30000, -- 300000 = 5 minutes in how many miliseconds should check the lucky number when crossing the location. if you put 0 it will defenitly spawn npcs Advise to keep it 50000
		x = -1406.96, y = -965.50, z = 61.75, -- location that triggers the ambush
		BlipHandle = 953018525, -- sprite of the npc blip. dont change
		DistanceTriggerMission = 13.0, -- distance from the location to trigger the ambush
		TimeToDeleteAlivePeds = 300000, --[ 300000 is = to 5 minutes.] if peds kill player time to delte peds for example you can be with someone and he can keep fighting then or someone can pass by and kill them to revive you
		DistanceToStopAmbush = 150, -- distance to stop the ambush when player is 150 away then ambush will stop
		MaxPeds = 10, -- this says dont spawn more than 10 per wave
		MaxAlive = 4, -- spawn how many - then when killed will keep spawning untill has reached MXAPEDS ^
		RandomPedSpawn = { min = 1, max = 3 }, -- random amount to spawn at first
		outlawsLocation = {
			{ x = -1364.356, y = -966.014, z = 72.52 }, -- location to spawn peds for each ped
			{ x = -1369.356, y = -960.0144, z = 72.52 },
			{ x = -1391.35, y = -985.014, z = 72.52 },
			{ x = -1480.86, y = -915.48, z = 80.94 },
			{ x = -1491.77, y = -944.48, z = 88.94 },
			{ x = -1491.77, y = -944.48, z = 88.94 },
		},
		outlawsModels = {
			{ hash = "G_M_M_UniBanditos_01" }, -- models it will pick a random model
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" }
		},

		--[[outlawsWeapons = {
			{ hash = "WEAPON_MELEE_MACHETE" }, -- random weapons it will pick a random weapon
			{ hash = "WEAPON_MELEE_MACHETE" },
			{ hash = "WEAPON_MELEE_MACHETE" },
			{ hash = "WEAPON_MELEE_MACHETE" },
			{ hash = "WEAPON_MELEE_MACHETE" },
		},]]
		Notification = "you are being ambushed by the notorious gang of black water",
	},

	secondLocation = {
		Random = { min = 1, max = 10 },
		luckynumber = 3,
		CheckLuckyNumber = 50000,
		x = -1370.55, y = 1471.54, z = 241.58, -- beartooth pass
		BlipHandle = 953018525,
		DistanceTriggerMission = 13.0,
		TimeToDeleteAlivePeds = 50000,
		DistanceToStopAmbush = 150, -- distance to stop the ambush when player is 150 away then ambush will stop
		MaxPeds = 10, -- this says dont spawn more than 10 per wave
		MaxAlive = 7, -- if random number is 3 will spawn 3 peds from the list [outlawsLocation] if this wave is 5 then for every kill  they will keep sapawning untill maxPedsToSpawn is reached.
		RandomPedSpawn = { min = 1, max = 6 },
		outlawsLocation = {
			{ x = -1362.819, y = 1429.0799, z = 234.409 },
			{ x = -1366.819, y = 1428.0799, z = 235.409 },
			{ x = -1359.819, y = 1423.0799, z = 234.409 },
		},

		outlawsModels = {
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" }
		},
		--[[outlawsWeapons = {
			{ hash = 0x772C8DD6 },
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},]]
		Notification = "you are being ambushed by the notorious gang of black water",
	},

	thirdLocation = {
		Random = { min = 1, max = 1 },
		luckynumber = 1,
		CheckLuckyNumber = 50000,
		x = 356.13, y = 442.88, z = 111.37, -- Citadel Rock area
		BlipHandle = 953018525,
		DistanceTriggerMission = 13.0,
		TimeToDeleteAlivePeds = 50000,
		DistanceToStopAmbush = 150, -- distance to stop the ambush when player is 150 away then ambush will stop
		MaxPeds = 10, -- this says dont spawn more than 10 per wave
		MaxAlive = 7, -- if random number is 3 will spawn 3 peds from the list [outlawsLocation] if this wave is 5 then for every kill  they will keep sapawning untill maxPedsToSpawn is reached.
		RandomPedSpawn = { min = 1, max = 6 },
		outlawsLocation = {
			{ x = 466.03, y = 376.79, z = 106.49 },
			{ x = 450.94, y = 367.32, z = 104.30 },
			{ x = 469.02, y = 376.98, z = 106.72 },
			{ x = 454.90, y = 377.63, z = 105.72 },
		},
		outlawsModels = {
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" }
		},
		--[[outlawsWeapons = {
			{ hash = 0x772C8DD6 },
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},]]
		Notification = "you are being ambushed by the notorious gang of black water",
	},

	fourthLocation = {
		Random = { min = 1, max = 10 },
		luckynumber = 1,
		CheckLuckyNumber = 50000,
		x = 2163.16, y = -1329.416, z = 42.50, -- Slaughter House Bridge
		BlipHandle = 953018525,
		DistanceTriggerMission = 13.0,
		TimeToDeleteAlivePeds = 50000,
		DistanceToStopAmbush = 150, -- distance to stop the ambush when player is 150 away then ambush will stop
		MaxPeds = 10, -- this says dont spawn more than 10 per wave
		MaxAlive = 7, -- if random number is 3 will spawn 3 peds from the list [outlawsLocation] if this wave is 5 then for every kill  they will keep sapawning untill maxPedsToSpawn is reached.
		RandomPedSpawn = { min = 1, max = 6 },
		outlawsLocation = {
			{ x = 2160.73, y = -1315.26, z = 41.35 },
			{ x = 2160.73, y = -1313.26, z = 41.39 },
			{ x = 2139.51, y = -1295.05, z = 41.32 },
			{ x = 2131.51, y = -1305.36, z = 41.54 }
		},
		outlawsModels = {
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" }
		},
		--[[outlawsWeapons = {
			{ hash = 0x772C8DD6 },
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},]]
		Notification = "you are being ambushed by the notorious gang of black water",
	}
	-- to add more just copy from above and make new coords
}
