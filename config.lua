Config = {}

Config.Cooldown = 540000 -- 9 minutes




Config.Bandits = {

	firstLocation = {

		luckynumber = 3,
		x = -1406.96, y = -965.50, z = 61.75, -- location to get notified
		outlawsLocation = {
			{ x = -1364.3565673828125, y = -966.014404296875, z = 72.52660369873047 }, -- location to spawn peds for each ped
			{ x = -1369.3565673828125, y = -960.014404296875, z = 72.52660369873047 },
			{ x = -1391.3565673828125, y = -985.014404296875, z = 72.52660369873047 },
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

		outlawsWeapons = {
			{ hash = 0x772C8DD6 }, -- random weapons it will pick a random weapon
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},
		Notification = "you are being ambushed by the notorious gang of black water",
	},

	secondLocation = {
		luckynumber = 3,
		{ x = -1370.55, y = 1471.54, z = 241.58 }, -- beartooth pass
		outlawsLocation = {
			{ x = -1362.81982421875, y = 1429.0799560546875, z = 234.40966796875 },
			{ x = -1366.81982421875, y = 1428.0799560546875, z = 235.40966796875 },
			{ x = -1359.81982421875, y = 1423.0799560546875, z = 234.40966796875 },
		},

		outlawsModels = {
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" },
			{ hash = "G_M_M_UniBanditos_01" }
		},
		outlawsWeapons = {
			{ hash = 0x772C8DD6 },
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},
		Notification = "you are being ambushed by the notorious gang of black water",
	},

	thirdLocation = {
		luckynumber = 3,
		{ x = 356.13, y = 442.88, z = 111.37 }, -- Citadel Rock area
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
		outlawsWeapons = {
			{ hash = 0x772C8DD6 },
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},
		Notification = "you are being ambushed by the notorious gang of black water",
	},

	fourthLocation = {
		luckynumber = 3,
		{ x = 2163.16, y = -1329.416, z = 42.50 }, -- Slaughter House Bridge
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
		outlawsWeapons = {
			{ hash = 0x772C8DD6 },
			{ hash = 0x169F59F7 },
			{ hash = 0xDB21AC8C },
			{ hash = 0x6DFA071B },
			{ hash = 0xF5175BA1 },
		},
		Notification = "you are being ambushed by the notorious gang of black water",
	}
	-- to add more just copy from above and make new coords
}
