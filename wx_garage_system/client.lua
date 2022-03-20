--#region include
Callback = exports.wx_module_system:RequestModule("Callback")
Render = exports.wx_module_system:RequestModule("Render")
--#endregion

--#region generat garage
Citizen.CreateThread(function()
    local garageList = Callback.TriggerServerCallback("wx_garage_system:getGarageList")

    --#region genarate blip
    for _, garage in pairs(garageList) do
        local decodePosition = json.decode(garage.GarageBlipPosition)
        garage.GarageBlipPosition = vec3(decodePosition.x,decodePosition.y,decodePosition.z)
        local blip = AddBlipForCoord(garage.GarageBlipPosition.x, garage.GarageBlipPosition.y, garage.GarageBlipPosition.z)
        SetBlipSprite(blip, garage.GarageBlipSprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, garage.GarageBlipColour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garage.GarageBlipName)
        EndTextCommandSetBlipName(blip)
    end
    --#endregion

    --#region genarate get vehicle marker
    for _, garage in pairs(garageList) do
        garage.GarageGetVehicleMarkerPosition = json.decode(garage.GarageGetVehicleMarkerPosition)
        garage.GarageGetVehicleMarkerPosition = vec3(garage.GarageGetVehicleMarkerPosition.x, garage.GarageGetVehicleMarkerPosition.y, garage.GarageGetVehicleMarkerPosition.z)
        garage.GarageGetVehicleMarkerColor = json.decode(garage.GarageGetVehicleMarkerColor)
        local marker = Render.Marker.DrawMarkerWithClass({
            type = garage.GarageGetVehicleMarkerType,
            positionX = garage.GarageGetVehicleMarkerPosition.x,
            positionY = garage.GarageGetVehicleMarkerPosition.y,
            positionZ = garage.GarageGetVehicleMarkerPosition.z,
            scaleX = 1.2,
            scaleY = 1.2,
            scaleZ = 1.2,
            colorR = garage.GarageGetVehicleMarkerColor.r,
            colorG = garage.GarageGetVehicleMarkerColor.g,
            colorB = garage.GarageGetVehicleMarkerColor.b,
            alpha = 140,
            onEnter = function()
                --TODO: 打开NUI -> 解锁某车辆 -> 扣费: 成功[pass]:失败[break] -> 渲染一个marker在车辆头上 -> 解锁车辆 -> 移除object pool
                exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("按下 ~INPUT_CONTEXT~ 查看车辆",true)
                if IsControlPressed(0,38) then
                    SetNuiFocus(true,true)
                    SendNUIMessage({
                        type = "openGarageVehicleList",
                        vehicleList = Callback.TriggerServerCallback("wx_garage_system:getGarageVehicleList"),
                        currentMoney = Callback.TriggerServerCallback("wx_garage_system:getCurrentMoney"),
                    })
                end
            end
        })
        marker.StartDraw()
    end
    --#region
end)
--#region