local CanStartAmbush = false
local Canstart = true
local myCreatedPeds = {}
local CanstartMission = true


---------------- NPC ---------------------
function LoadModel(model)
	local Model = GetHashKey(model)
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		RequestModel(model)
		Citizen.Wait(100)
	end
end

function AreMissionPedsAlive()
	if CanStartAmbush then
		for _, ped in ipairs(myCreatedPeds) do
			if DoesEntityExist(ped) then
				if not IsEntityDead(ped) then
					return true
				end
			end
		end
	end
	return false
end

CreateThread(function()
	while Canstart do
		Wait(0)
		local playerID = PlayerId()
		local playerDead = IsPlayerDead(playerID)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local sleep = true
		print(CanstartMission)
		for key, Location in pairs(Config.Outlaws) do

			local coordsDist = vector3(coords.x, coords.y, coords.z)
			local coordsLocation = vector3(Location.x, Location.y, Location.z)
			local distance = #(coordsDist - coordsLocation)

			if distance <= Location.DistanceTriggerMission then
				sleep = false --break the loop
				local random = math.random(Location.Random.min, Location.Random.max)

				if CanstartMission and playerDead ~= true then
					TriggerServerEvent("vorp_outlaws:once", key)
					Wait(200)
					print("wait for trigger")

					if random == Location.luckynumber then -- start ambush

						Wait(100)
						Canstart = false
						-- check if can start
						TriggerEvent('vorp:ShowTopNotification', "~e~AMBUSH", Location.Notification, 4000)

						for _, positions in pairs(Location.outlawsLocation) do

							local modelNumeroRandom = math.random(1, 1)
							local modelRandom = Location.outlawsModels[modelNumeroRandom].hash
							local modelHash = GetHashKey(modelRandom)
							LoadModel(modelRandom)


							local createdped = CreatePed(modelHash, positions.x, positions.y, positions.z, true, true, true, true)

							if DoesEntityExist(createdped) then
								local bliptype = Location.BlipHandle -- add to config
								Citizen.InvokeNative(0x283978A15512B2FE, createdped, true) -- random outfit
								Citizen.InvokeNative(0x23f74c2fda6e7c61, bliptype, createdped) -- blip 
								--CanPedBeMounted(createdped, false)
								TaskCombatPed(createdped, PlayerPedId()) -- combat ped
								Wait(100)
								myCreatedPeds[#myCreatedPeds + 1] = createdped -- add to table
								SetModelAsNoLongerNeeded(modelHash)
								CanStartAmbush = true
								Wait(100)
							end

						end

					else
						Wait(Location.CheckLuckyNumber) -- add a wait untill the mission can run again to stop looping
						Canstart = true -- can run the mission
					end
				end
				while CanStartAmbush do
					Wait(0)

					if not AreMissionPedsAlive() then -- is all entities dead
						CanStartAmbush = false
						Canstart = true
						TriggerEvent('vorp:ShowTopNotification', "~e~You Have Defeated The Bandits!", "Safe Travels...", 4000)
						for k, ped in ipairs(myCreatedPeds) do
							print(ped, k)
							table.remove { myCreatedPeds, k } -- remove from table
							SetEntityAsNoLongerNeeded(ped) -- engine will remove leave the dead 
							myCreatedPeds = {}
							Canstart = true
							print("available")

							TriggerServerEvent("name", key)
							print(key)
						end
					end

					if IsPlayerDead(playerID) then
						CanStartAmbush = false
						Canstart = true
						for k, ped in ipairs(myCreatedPeds) do
							if DoesEntityExist(ped) then
								table.remove { myCreatedPeds, k }
								SetEntityAsNoLongerNeeded(ped) -- no longer needed engine will delete them
								--Wait(Location.TimeToDeleteAlivePeds) -- wait incase you want players to come save him before deleting
								DeletePed(ped)
								DeleteEntity(ped) -- delete all created
								myCreatedPeds = {}
								--Canstart = true
								TriggerServerEvent("name", key)
								print(key)
							end
						end
					end

				end
			end
		end
		if sleep then
			Wait(3000)
		end

	end
end)




AddEventHandler('onResourceStop', function()
	for k, ped in ipairs(myCreatedPeds) do
		if DoesEntityExist(ped) then
			table.remove { myCreatedPeds, k }
			DeletePed(ped) --delete
			DeleteEntity(ped) -- delete after a certain time in case you have friends to save you 
			SetEntityAsNoLongerNeeded(ped) -- no longer needed engine will delete them
			myCreatedPeds = {}
		end
	end
	Canstart = true
end)

RegisterNetEvent("vorp_outlaws:canstart", function(can)
	CanstartMission = can
end)
