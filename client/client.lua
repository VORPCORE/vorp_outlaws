local myCreatedPeds = {}
local CanStartSecondState = true
local LocationName = ""
local CanSpawnPeds = true
local CanStart = 1
local NameLocation = {}
local StartLoop = true
local near = 100

---------------- NPC ---------------------

local function CreateMissionPed(model, position, blipSprite, pedToAttack)
	if not IsModelInCdimage(model) then
		print("Model is not loaded in the CDI")
		return
	end
	if not HasModelLoaded(model) then
		RequestModel(model, false)
		repeat Wait(0) until HasModelLoaded(model)
	end
	local modelHash = GetHashKey(model)
	local createdped = CreatePed(modelHash, position.x, position.y, position.z, 0.0, true, false, false, false)
	repeat Wait(0) until DoesEntityExist(createdped)

	SetPedRelationshipGroupHash(createdped, `bandits`)
	SetRelationshipBetweenGroups(5, `PLAYER`, `bandits`)
	SetRelationshipBetweenGroups(5, `bandits`, `PLAYER`)
	Citizen.InvokeNative(0x283978A15512B2FE, createdped, true)
	Citizen.InvokeNative(0x23f74c2fda6e7c61, blipSprite, createdped)
	TaskCombatPed(createdped, pedToAttack, 0, 0)
	SetEntityAsMissionEntity(createdped, true, true)
	Citizen.InvokeNative(0x740CB4F3F602C9F4, createdped, true)
	myCreatedPeds[#myCreatedPeds + 1] = createdped
	SetModelAsNoLongerNeeded(modelHash)
end

local function GetNumberOfAliveMissionPeds()
	local numberOfAlivePeds = 0

	for _, ped in ipairs(myCreatedPeds) do
		if DoesEntityExist(ped) then
			if not IsEntityDead(ped) then
				numberOfAlivePeds = numberOfAlivePeds + 1
			end
		end
	end

	return numberOfAlivePeds
end

local function CreateMissionPeds(currentMission, numberToSpawn)
	if #myCreatedPeds == currentMission.MaxPeds then
		CanSpawnPeds = true
		return
	end

	local playerToAttack = PlayerPedId()

	for x = 1, numberToSpawn do
		local numberOfAlivePeds = GetNumberOfAliveMissionPeds()

		if numberOfAlivePeds >= currentMission.MaxAlive then
			return
		end

		local randomSpawn = math.random(1, #currentMission.outlawsLocation)
		local position = currentMission.outlawsLocation[randomSpawn]
		local randomNumber = math.random(1, #currentMission.outlawsModels)
		local modelRandom = currentMission.outlawsModels[randomNumber].hash
		CreateMissionPed(modelRandom, position, currentMission.BlipHandle, playerToAttack)
	end
end


local function GetPlayerDistanceFromCoords(x, y, z)
	local playerPos = GetEntityCoords(PlayerPedId())
	local playerVector = vector3(playerPos.x, playerPos.y, playerPos.z)
	local posVector = vector3(x, y, z)
	return #(playerVector - posVector)
end

local function CleanUpAndReset(Deletenpc)
	for _, ped in ipairs(myCreatedPeds) do
		if DoesEntityExist(ped) then
			if Deletenpc then
				DeletePed(ped)
				DeleteEntity(ped)
			end

			SetEntityAsMissionEntity(ped, false, false)
			SetEntityAsNoLongerNeeded(ped)
		end
	end
	TriggerServerEvent("vorp_outlaws:remove", LocationName)
	LocationName = ""
	myCreatedPeds = {}
	NameLocation = {}
end

local function MissionPedManager()
	CreateThread(function()
		while not CanSpawnPeds do
			Wait(0)

			if #myCreatedPeds == NameLocation.MaxPeds then
				CanSpawnPeds = true
			end

			local numberOfAlivePeds = GetNumberOfAliveMissionPeds()
			if numberOfAlivePeds <= NameLocation.MaxAlive then
				CreateMissionPeds(NameLocation,
					math.random(NameLocation.RandomPedSpawn.min, NameLocation.RandomPedSpawn.max))
			end
		end
	end
	)
end

--Events
AddEventHandler('onResourceStop', function()
	CleanUpAndReset(true)
	CanSpawnPeds = false
end)


RegisterNetEvent("vorp_outlaws:canstart", function(can)
	CanStartSecondState = can
end)


CreateThread(function()
	while StartLoop do
		Wait(near)
		local playerID = PlayerId()
		local playerDead = IsPlayerDead(playerID)

		if CanStart == 1 then
			for key, Location in pairs(Config.Outlaws) do
				local distance = GetPlayerDistanceFromCoords(Location.x, Location.y, Location.z)

				if distance <= Location.DistanceTriggerMission then
					near = 0
					LocationName = key
					NameLocation = Location
					CanStart = 2
				else
					near = 100
				end
			end
		end

		if CanStart == 2 then
			local random = math.random(NameLocation.Random.min, NameLocation.Random.max)
			if random == NameLocation.luckynumber then   
				TriggerServerEvent("vorp_outlaws:check", LocationName) 
				Wait(2000)                                 
				print(CanStartSecondState)
				if CanStartSecondState and not playerDead then
					local numberOfAlivePeds = GetNumberOfAliveMissionPeds()

					if numberOfAlivePeds <= NameLocation.MaxAlive then
						CreateMissionPeds(NameLocation,	math.random(NameLocation.RandomPedSpawn.min, NameLocation.RandomPedSpawn.max))
						CanSpawnPeds = false
						Wait(100)
						MissionPedManager()
						CanStart = 3
						TriggerEvent('vorp:ShowTopNotification', NameLocation.NotificationTitle,
							NameLocation.Notification, 2000)
					end
				else      
					Wait(Config.Cooldown) 
					CanStart = 1 
					StartLoop = true 
				end
			else         
				Wait(Config.Cooldown) 
				CanStart = 1 
				StartLoop = true 
			end
		end

		if CanStart == 3 then
			local numberOfPedsKilled = NameLocation.MaxPeds - GetNumberOfAliveMissionPeds()
			local DistanceFromArea = GetPlayerDistanceFromCoords(NameLocation.x, NameLocation.y, NameLocation.z) 

			if numberOfPedsKilled == NameLocation.MaxPeds then
				CanStart = 1
				CanSpawnPeds = true
				Wait(200)
				StartLoop = false
				TriggerEvent('vorp:ShowTopNotification', NameLocation.NotificationKilledTitle,NameLocation.NotificationKilled, 4000)
				CleanUpAndReset(false)
				Wait(Config.Cooldown)
				StartLoop = true
			end

			if DistanceFromArea > NameLocation.DistanceToStopAmbush then
				CanStart = 1
				CanSpawnPeds = true
				Wait(200)
				StartLoop = false
				TriggerEvent('vorp:ShowTopNotification', NameLocation.NotificationEscapeTitle,NameLocation.NotificationEscape, 4000)
				CleanUpAndReset(true)
				Wait(Config.Cooldown)
				StartLoop = true
			end

			if IsPlayerDead(playerID) then -- if player dead
				CanStart = 1
				CanSpawnPeds = true
				Wait(200)
				StartLoop = false
				TriggerEvent('vorp:updatemissioNotify', NameLocation.NotificationDiedTitle, NameLocation.NotificationDied, 4000)
				Wait(Config.DeleteNPcsAfterPlayerDied)
				CleanUpAndReset(true)
				Wait(Config.Cooldown)
				StartLoop = true
			end
		end
	end
end)
