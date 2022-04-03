local Callback = exports.wx_module_system:RequestModule("Callback")
local searchFequency = 10000

Citizen.CreateThread(function()
    while true do
        local object = GetGamePool("CObject")
        for _, entity in ipairs(object) do
            if string.find(GetEntityArchetypeName(entity),"atm") ~= nil then
                DrawATM(entity)
            end
        end
        Wait(searchFequency)
    end
end)

function DrawATM(entity)
    local shouldDraw = true
    local blip
    Citizen.CreateThread(function()
        local entityCoords = GetEntityCoords(entity)
        blip = AddBlipForEntity(entity)
        SetBlipSprite(blip, 108)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("附近的ATM机")
        EndTextCommandSetBlipName(blip)

        while shouldDraw do
            Wait(1)
            if IsSphereVisible(entityCoords, 0.1 --[[ number ]]) then
                DrawMarker(
                    1,
                    entityCoords,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    2.5,
                    2.5,
                    1.0,
                    25,
                    255,
                    255,
                    140,
                    false,
                    false,
                    false,
                    false,
                    nil,
                    nil,
                    false
                )
            end
            if Vdist2(GetEntityCoords(GetPlayerPed(-1)), entityCoords) < 2.6 then
                exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("按~INPUT_PICKUP~使用ATM鸡",true)
                if IsControlJustPressed(0,38) then
                    SetNuiFocus(true,true)
                    SendNUIMessage({
                        type = "showAtm",
                        currentCardList = Callback.TriggerServerCallback("wx_bank:getCardList"),
                        currentMoney = tonumber(Callback.TriggerServerCallback("wx_bank:getMoney")),
                    })
                end
            end
        end
    end)
    Citizen.SetTimeout(searchFequency, function()
        shouldDraw = false
        RemoveBlip(blip)
    end)
end


