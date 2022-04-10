local phoneObject
local Utils = exports.wx_module_system:RequestModule("Utils")

RegisterNetEvent("wx_phone:usePhone",function(phoneData)
    SetNuiFocus(true,true)
    SendNUIMessage({
        type = "show",
        phoneData = phoneData
    })
    phoneObject = CreateObject(
        GetHashKey("prop_phone_proto"),
        0.0,0.0,0.0,
        true,true,false
    )
    AttachEntityToEntity(
        phoneObject,
        PlayerPedId(),
        GetPedBoneIndex(PlayerPedId(), 0xFA70),
        -0.0,0.05,0.0,
        10.0,90.0,180.0,
        false,
        false,
        false,
        false,
        false,
        true
    )

    RequestAnimDict("cellphone@")
    while not HasAnimDictLoaded("cellphone@") do
        Wait(0)
    end

    TaskPlayAnim(
        PlayerPedId(),
        "cellphone@",
        "cellphone_text_in",
        Utils.GenerateRandomFloat(2.0,8.0),
        Utils.GenerateRandomFloat(2.0,8.0),
        -1,
        50,
        1.0,
        false,
        false,
        false
    )
end)

RegisterNUICallback("HideCurse", function(data,cb)
    SetNuiFocus(false,false)
    DetachEntity(phoneObject,true,true)
    DeleteEntity(phoneObject)
    ClearPedTasks(PlayerPedId())
    phoneObject = nil
    collectgarbage()
end)