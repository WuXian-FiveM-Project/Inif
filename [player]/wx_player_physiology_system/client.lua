Callback = exports.wx_module_system:RequestModule("Callback")
Citizen.CreateThread(function()
    local v = Callback.TriggerServerCallback("wx_player_physiology_system:requestPhysiology")
    SendNUIMessage({
        type = "satiety",
        value = v.satiety
    })
    SendNUIMessage({
        type = "thirst",
        value = v.thirst
    })
    SendNUIMessage({
        type = "tiredness",
        value = v.tiredness
    })
end)

RegisterNetEvent("wx_player_physiology_system:UpdateSatiety",function(value)
    SendNUIMessage({
        type = "satiety",
        value = value
    })
end)

RegisterNetEvent("wx_player_physiology_system:UpdateThirst",function(value)
    SendNUIMessage({
        type = "thirst",
        value = value
    })
end)


RegisterNetEvent("wx_player_physiology_system:UpdateTiredness",function(value)
    SendNUIMessage({
        type = "tiredness",
        value = value
    })
end)