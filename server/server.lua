local ActiveMissions = {}

function IsMissionActive(key)
    for _, mission in pairs(ActiveMissions) do
        if key == mission then
            print("misions exist cant start")
            return true
        end
    end
    print("mission dont exist can start")
    return false
end

function RemoveFromTableByName(ActiveMissions, removeAmbush)
    local indexToRemove = 0

    for index, name in pairs(ActiveMissions) do
        if removeAmbush == name then
            indexToRemove = index
        end
    end
    if indexToRemove == 0 then
        return false -- no mission removed
    end
    -- else remove
    table.remove(ActiveMissions, indexToRemove)
    return true -- mission was removed
end

RegisterServerEvent("vorp_outlaws:check", function(ambushLocation)
    local _source = source

    if IsMissionActive(ambushLocation) then
        --cant start
        CanStart = false
        TriggerClientEvent("vorp_outlaws:canstart", _source, CanStart) -- say to client cant start
        print("cant")
    end
    ActiveMissions[#ActiveMissions + 1] = ambushLocation --insert location
    CanStart = true
    TriggerClientEvent("vorp_outlaws:canstart", _source, CanStart) -- say to client its can start
    print("can")
end)

RegisterServerEvent("vorp_outlaws:remove", function(removeAmbush)
    local _source = source
    RemoveFromTableByName(ActiveMissions, removeAmbush)
    print(RemoveFromTableByName(ActiveMissions, removeAmbush))
end)
