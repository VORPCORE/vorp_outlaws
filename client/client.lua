local myCreatedPeds = {}
local CanStartSecondState = true
local LocationName = ""
local CanSpawnPeds = true
local CanStart = 1
local NameLocation = {}
local StartLoop = true




---------------- NPC ---------------------

function CreateMissionPed(model, position, blipSprite, pedToAttack)
	local modelHash = GetHashKey(model)
	if not IsModelInCdimage(modelHash) then
		print("Model is not loaded in the CDI")
		return;
	end
	while not HasModelLoaded(modelHash) do -- might want to runa  failure count
		RequestModel(modelHash)
		Citizen.Wait(0)
	end
	local createdped = CreatePed(modelHash, position.x, position.y, position.z, true, true, false, false)

	if DoesEntityExist(createdped) then
		Citizen.InvokeNative(0x283978A15512B2FE, createdped, true) -- random outfit
		Citizen.InvokeNative(0x23f74c2fda6e7c61, blipSprite, createdped) -- blip 
		TaskCombatPed(createdped, pedToAttack) -- combat ped
		SetEntityAsMissionEntity(createdped, true, true)
		Citizen.InvokeNative(0x740CB4F3F602C9F4, createdped, true); -- This script must clean up, set false if there are issues
		myCreatedPeds[#myCreatedPeds + 1] = createdped -- add to table
		SetModelAsNoLongerNeeded(modelHash)
	end
end

function CreateMissionPeds(currentMission, numberToSpawn)

	if #myCreatedPeds == currentMission.MaxPeds then
		CanSpawnPeds = true -- stop loop if max peds is achieved
		return
	end

	print("Creating peds for mission")
	local playerToAttack = PlayerPedId()

	for x = 1, numberToSpawn do
		local numberOfAlivePeds = GetNumberOfAliveMissionPeds() -- check how many are alive

		if numberOfAlivePeds >= currentMission.MaxAlive then -- if number of alive is more or equals config max alive then stop creating.
			return
		end

		local randomSpawn = math.random(1, #currentMission.outlawsLocation)
		local position = currentMission.outlawsLocation[randomSpawn]
		local randomNumber = math.random(1, #currentMission.outlawsModels)
		local modelRandom = currentMission.outlawsModels[randomNumber].hash
		CreateMissionPed(modelRandom, position, currentMission.BlipHandle, playerToAttack)

	end
end

function AreMissionPedsAlive()
	for _, ped in ipairs(myCreatedPeds) do
		if DoesEntityExist(ped) then
			if not IsEntityDead(ped) then
				return true
			end
		end
	end

	return false
end

function GetNumberOfAliveMissionPeds()
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

function AreMissionPedsAlive()
	return GetNumberOfAliveMissionPeds() > 0
end

function GetPlayerDistanceFromCoords(x, y, z)
	local playerPos = GetEntityCoords(PlayerPedId())
	local playerVector = vector3(playerPos.x, playerPos.y, playerPos.z)
	local posVector = vector3(x, y, z)
	return #(playerVector - posVector)
end

function CleanUpAndReset(Deletenpc)

	for _, ped in ipairs(myCreatedPeds) do
		if DoesEntityExist(ped) then
			if Deletenpc then
				DeletePed(ped) --delete
				DeleteEntity(ped) -- delete after a certain time in case you have friends to save you 
			end

			SetEntityAsMissionEntity(ped, false, false)
			SetEntityAsNoLongerNeeded(ped) -- no longer needed engine will delete them
		end
	end
	TriggerServerEvent("vorp_outlaws:remove", LocationName) -- remove from server and allow other players to trigger mission
	LocationName = ""
	myCreatedPeds = {}
	NameLocation = {}
	Wait(NameLocation.CheckLuckyNumber)
	print(NameLocation.CheckLuckyNumber)
	CanStart = 1
end

function MissionPedManager()
	CreateThread(
		function()
			while not CanSpawnPeds do
				Wait(0)

				if #myCreatedPeds == NameLocation.MaxPeds then -- if achieved then
					print("loop stop peds creating")
					CanSpawnPeds = true -- stop loop if max peds is achieved
				end

				local numberOfAlivePeds = GetNumberOfAliveMissionPeds()
				if numberOfAlivePeds <= NameLocation.MaxAlive then -- if not reached max alive keep spawning when they die
					print("keep creating")
					CreateMissionPeds(NameLocation, math.random(NameLocation.RandomPedSpawn.min, NameLocation.RandomPedSpawn.max)) -- you can change this randomiser
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

	while StartLoop == false do
		Wait(0)
		print("loop started")
		local playerID = PlayerId()
		local playerDead = IsPlayerDead(playerID)

		if CanStart == 0 then
			CleanUpAndReset(true)
			--StartLoop = false -- stop loop npcs are dead or player escaped or player is dead
		end
		if CanStart == 1 then
			for key, Location in pairs(Config.Outlaws) do
				local distance = GetPlayerDistanceFromCoords(Location.x, Location.y, Location.z)

				if distance <= Location.DistanceTriggerMission then
					LocationName = key
					NameLocation = Location
					CanStart = 2
				end
			end
		end

		if CanStart == 2 then
			local random = math.random(NameLocation.Random.min, NameLocation.Random.max)
			if random == NameLocation.luckynumber then -- check if player is lucky
				TriggerServerEvent("vorp_outlaws:check", LocationName) -- check if can start
				Wait(2000) -- give time to update

				if CanStartSecondState and not playerDead then
					local numberOfAlivePeds = GetNumberOfAliveMissionPeds()

					if numberOfAlivePeds <= NameLocation.MaxAlive then
						CreateMissionPeds(NameLocation, math.random(NameLocation.RandomPedSpawn.min, NameLocation.RandomPedSpawn.max))
						CanSpawnPeds = false
						Wait(100)
						MissionPedManager()
						CanStart = 3
						TriggerEvent('vorp:ShowTopNotification', "~e~AMBUSH", NameLocation.Notification, 2000)


					end
				else -- if someone is being ambushed cant start
					Wait(NameLocation.CheckLuckyNumber) -- add a wait untill the mission can run again to stop looping
					CanStart = 1 -- can start
					StartLoop = true -- start loop

				end

			else -- not lucky
				Wait(NameLocation.CheckLuckyNumber) -- add a wait untill the mission can run again to stop looping
				CanStart = 1 -- can start
				StartLoop = true -- start loop
			end
		end

		if CanStart == 3 then
			local numberOfPedsKilled = NameLocation.MaxPeds - GetNumberOfAliveMissionPeds()
			local DistanceFromArea = GetPlayerDistanceFromCoords(NameLocation.x, NameLocation.y, NameLocation.z) -- check  distance between player and location

			-- If the player has killed all the allowed peds to be spawned, then the area is cleared.
			if numberOfPedsKilled == NameLocation.MaxPeds then
				CanSpawnPeds = true
				TriggerEvent('vorp:ShowTopNotification', "you have killed them all", "Safe Travels...", 4000)
				CanStart = 0
			end


			if DistanceFromArea > NameLocation.DistanceToStopAmbush then
				CanSpawnPeds = true
				TriggerEvent('vorp:ShowTopNotification', "!you have escaped!", "keep an eye on the road", 4000)
				CanStart = 0
			end

			if IsPlayerDead(playerID) then -- if player dead
				CanSpawnPeds = true

				TriggerEvent('vorp:updatemissioNotify', "!you have been killed!", "bandits will stay for awhile", 4000)
				CanStart = 0

			end

		end

	end
end)
