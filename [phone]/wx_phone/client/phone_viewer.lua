RegisterNetEvent("wx_phone:usePhone",function(phoneData)
    SetNuiFocus(true,true)
    SendNUIMessage({
        type = "show",
        phoneData = phoneData
    })
end)

RegisterNUICallback("HideCurse", function(data,cb)
    SetNuiFocus(false,false)
end)