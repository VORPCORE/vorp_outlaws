local Active
local ActiveMissions = {}

RegisterServerEvent("vorp_outlaws:once", function(key)
    local _source = source

    for k, v in pairs(ActiveMissions) do
        if key ~= v then
            CanStart = true

        else
            CanStart = false
        end
    end

    if CanStart then
        ActiveMissions[#ActiveMissions + 1] = key

        TriggerClientEvent("name", _source, false) -- say to client its false
    else
        -- cant start
    end
end)



RegisterServerEvent("name", function(key)

    for k, value in pairs(ActiveMissions) do
        print(key, value)
        if key == value then

            table.remove(ActiveMissions, value[k])

            print(value)
            print(key)
        end
    end
end)
