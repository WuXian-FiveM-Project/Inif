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
    TriggerServerEvent("wx_player_physiology_system:createInstance")
end)
Utils = exports.wx_module_system:RequestModule("Utils")

RegisterNetEvent("wx_player_physiology_system:UpdateSatiety",function(value)
    SendNUIMessage({
        type = "satiety",
        value = Utils.Round(value,2)
    })
end)

RegisterNetEvent("wx_player_physiology_system:UpdateThirst",function(value)
    SendNUIMessage({
        type = "thirst",
        value = Utils.Round(value,2)
    })
end)


RegisterNetEvent("wx_player_physiology_system:UpdateTiredness",function(value)
    SendNUIMessage({
        type = "tiredness",
        value = Utils.Round(value,2)
    })
end)

RegisterNetEvent("wx_player_physiology_system:UpdateShit",function(value)
    SendNUIMessage({
        type = "shit",
        value = Utils.Round(value,2)
    })
end)

RegisterNetEvent("wx_player_physiology_system:UpdateUrine",function(value)
    SendNUIMessage({
        type = "urine",
        value = Utils.Round(value,2)
    })
end)

RegisterNetEvent("wx_player_physiology_system:doTirednessBlackOut",function(howStrong)
    local time2 = 1
    if howStrong < 10 then time2 = 0 end
    local isloop = true
    Citizen.SetTimeout(20, function() isloop = false end)
    while isloop do
        Wait(0)
        SetPedToRagdoll(
        	PlayerPedId() --[[ Ped ]], 
        	0 --[[ integer ]], 
        	time2 --[[ integer ]], 
        	0 --[[ integer ]], 
        	false --[[ boolean ]], 
        	false --[[ boolean ]], 
        	false --[[ boolean ]]
        )
    end
end)


RegisterNetEvent("wx_player_physiology_system:doSatietyBlackOut",function(howStrong)
    howStrong = (100 - howStrong) * 0.01
    DoScreenFadeOut(
        Utils.GenerateRandomInt(10,500) --[[ integer ]]
    )
    Wait(howStrong)
    DoScreenFadeIn(
        Utils.GenerateRandomInt(10,500) --[[ integer ]]
    )
end)