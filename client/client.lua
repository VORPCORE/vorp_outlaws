local starting = false
local already = false
local count = {}
local createdped = {}
local chossenCoords = {}

function Missionstart()

	for index, value in pairs(Config.Bandits) do
		chossenCoords = value.outlawsLocation
		local modelNumeroRandom = math.random(6)
		local modelRandom = value.outlawsModels[modelNumeroRandom].hash
		local modelHash = GetHashKey(modelRandom)

		RequestModel(modelHash)
		if not HasModelLoaded(modelHash) then
			RequestModel(modelHash)
		end

		while not HasModelLoaded(modelHash) do
			Wait(0)
		end

		createdped[index] = CreatePed(modelHash, value.x, value.y, value.z, true, true, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, createdped[index], true)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped[index])
		Citizen.InvokeNative(0x8D9BFCE3352DE47F, createdped[index])
		TaskCombatPed(createdped[index], PlayerPedId())
		count[index] = createdped[index]

	end

	starting = true
	Wait(1000)
end

CreateThread(function()
	local AlivePed = #chossenCoords
	local playerID = PlayerId()
	--local qued = Citizen.InvokeNative(0x8D9BFCE3352DE47F, v)
	while starting do

		for key, peds in pairs(createdped) do
			if IsEntityDead(peds) then
				if count[key] then
					AlivePed = AlivePed - 1
					count[key] = nil
					if AlivePed == 0 then
						TriggerEvent('vorp:ShowTopNotification', "~e~You Have Defeated The Bandits!", "Safe Travels...", 4000)
						Wait(Config.Cooldown)
						starting = false
						already = false
						table.remove { createdped }
						table.remove { count }

					end
				end
			end
			if IsPlayerDead(playerID) then
				Stopmission()
			end
		end
		Wait(0)
	end
end)



function Stopmission()
	Wait(1000)
	pressing = false
	starting = false
	already = false
	--if IsEntityDead(count) and IsEntityDead(createdped) then
	for k, v in pairs(createdped) do
		DeletePed(v)
		DeletePed(count[k])

		Wait(500)
	end
	table.remove { createdped }
	table.remove { count }
	createdped = {}
	count = {}
	print("missiondone")
end

CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for k, Location in pairs(Config.Bandits) do

			--for key, value in pairs(first) do

			local coordsDist = vector3(coords.x, coords.y, coords.z)
			local coordsLocation = vector3(Location.x, Location.y, Location.z)
			local distance = #(coordsDist - coordsLocation)

			if distance <= 13.0 and not already then
				local random = math.random(1, 10)

				if random <= Location.luckynumber then
					print(random)
					--startdialog()
					Missionstart()

					already = true
				else
					if random > 2 and not already then
						stopmission()
						print(random)
					end
				end

			end
			--end
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for k, v in pairs(Config.holdup.second) do
			local distance = GetDistanceBetweenCoords(coords, v['x'], v['y'], v['z'], true)
			if distance < 3.0 and not already then
				local random = math.random(1, 10)
				if random <= Config.lotterynumber then

					print(random)
					startdialog2()
					missionstart2()

					already = true

				else
					if random > 2 and not already == true then
						stopmission()
						print(random)
					end
				end

			end
		end

	end
end)
