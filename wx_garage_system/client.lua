--#region include
local Callback = exports.wx_module_system:RequestModule("Callback")
local Render = exports.wx_module_system:RequestModule("Render")
local Utils = exports.wx_module_system:RequestModule("Utils")
--#endregion
local vehicleList = {}
local vehicleEntityList = {} --index by VID

--#region generat garage
Citizen.CreateThread(function()
    local garageList = Callback.TriggerServerCallback("wx_garage_system:getGarageList")[1]

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
                if IsControlJustPressed(0,38) then
                    local vehicleList = Callback.TriggerServerCallback("wx_garage_system:getGarageVehicleList",garage.GID)[1]
                    for index, value in pairs(vehicleList) do
                        vehicleList[index].StoreDate = value["UNIX_TIMESTAMP(cast(StoreDate as datetime))*1000"]
                    end
                    
                    SetNuiFocus(true,true)
                    SendNUIMessage({
                        type = "openGarageVehicleList",
                        vehicleList = vehicleList,
                        garageData = garage,
                        currentMoney = Callback.TriggerServerCallback("wx_garage_system:getCurrentMoney")[1],
                    })
                end
            end
        })
        marker.StartDraw()
    end
    --#endregion

    --#region spawn vehicle
    vehicleList = Callback.TriggerServerCallback("wx_garage_system:getVehicleList")
    for _, vehicle in pairs(vehicleList) do
        SpawnParkingVehicle(vehicle)
    end
    --#endregion

    --#region genarate store vehicle marker
    for _, garage in pairs(garageList) do
        garage.GarageStoreVehicleMarkerPosition = json.decode(garage.GarageStoreVehicleMarkerPosition)
        garage.GarageStoreVehicleMarkerPosition = vec3(garage.GarageStoreVehicleMarkerPosition.x, garage.GarageStoreVehicleMarkerPosition.y, garage.GarageStoreVehicleMarkerPosition.z)
        garage.GarageStoreVehicleMarkerColor = json.decode(garage.GarageStoreVehicleMarkerColor)
        local marker
        marker = Render.Marker.DrawMarkerWithClass({
            type = garage.GarageStoreVehicleMarkerType,
            positionX = garage.GarageStoreVehicleMarkerPosition.x,
            positionY = garage.GarageStoreVehicleMarkerPosition.y,
            positionZ = garage.GarageStoreVehicleMarkerPosition.z,
            scaleX = 4.5,
            scaleY = 4.5,
            scaleZ = 2.0,
            colorR = garage.GarageStoreVehicleMarkerColor.r,
            colorG = garage.GarageStoreVehicleMarkerColor.g,
            colorB = garage.GarageStoreVehicleMarkerColor.b,
            alpha = 140,
            onEnter = function()
                if GetVehiclePedIsIn(GetPlayerPed(-1),false) == 0 then
                    exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("~y~请先上车",true)
                else
                    exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("按下 ~INPUT_CONTEXT~ 停车 \n停车费: ~g~$"..garage.GarageCostPerHours.."/小时~s~",true)
                    if IsControlJustPressed(0,38) then
                        local cb = Callback.TriggerServerCallback('wx_garage_system:checkCanVehicleStoreInGarage',garage.GID)
                        if cb == "Full" then
                            exports.wx_module_system:RequestModule("Notification").ShowPopupWarning("停车场警告","停车场已满,请稍后再试","",2000)
                        else
                            Wait(200)
                            while true do
                                Wait(1)
                                exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("请把车停到停车格上，然后按下~g~~INPUT_CONTEXT~~s~键保存位置",true)
                                if IsControlJustPressed(0,38) then
                                    TriggerServerEvent("wx_garage_system:storeVehicle",
                                        garage.GID,
                                        Utils.GetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1),false)),
                                        GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1),false)) --[[ Hash ]]),
                                        GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)),
                                        GetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1),false))
                                    )
                                    DeleteEntity(GetVehiclePedIsIn(GetPlayerPed(-1),false) --[[ Entity ]])
                                    break
                                end
                            end
                        end
                    end
                end
            end
        })
        marker.StartDraw()
    end
    --#endregion
end)
--#endregion

function SpawnParkingVehicle(vehicle)
    Citizen.CreateThread(function()
        vehicle.VehiclePosition = json.decode(vehicle.VehiclePosition)
        vehicle.VehiclePosition = vec3(vehicle.VehiclePosition.x, vehicle.VehiclePosition.y, vehicle.VehiclePosition.z)
        vehicle.VehicleParms = json.decode(vehicle.VehicleParms)
        RequestModel(GetHashKey(vehicle.VehicleModule)) -- Request the model
        while not HasModelLoaded(GetHashKey(vehicle.VehicleModule)) do -- Waits for the model to load with a check so it does not get stuck in an infinite loop
            Citizen.Wait(10)
            RequestModel(GetHashKey(vehicle.VehicleModule))
        end
        local isInRenderDistance --[[ boolean ]], groundZ --[[ number ]] = GetGroundZFor_3dCoord(vehicle.VehiclePosition.x --[[ number ]], vehicle.VehiclePosition.y --[[ number ]], vehicle.VehiclePosition.z --[[ number ]], false --[[ boolean ]])
        if isInRenderDistance then
            vehicle.VehiclePosition = vec3(vehicle.VehiclePosition.x,vehicle.VehiclePosition.y,groundZ)
        end
        local vehicleEntity
        repeat
            vehicleEntity = CreateVehicle(
                GetHashKey(vehicle.VehicleModule),
                vehicle.VehiclePosition.x,
                vehicle.VehiclePosition.y,
                vehicle.VehiclePosition.z,
                vehicle.VehicleHeading,
                false,
                false
            )
        until vehicleEntity ~= nil
        FreezeEntityPosition(vehicleEntity,true)
        SetVehicleDoorsLocked(vehicleEntity --[[ Vehicle ]],2 --[[ integer ]])
        --[[
            enum eCarLock {
                CARLOCK_NONE = 0,
                CARLOCK_UNLOCKED = 1,
                CARLOCK_LOCKED = 2,
                CARLOCK_LOCKOUT_PLAYER_ONLY = 3,
                CARLOCK_LOCKED_PLAYER_INSIDE = 4,
                CARLOCK_LOCKED_INITIALLY = 5,
                CARLOCK_FORCE_SHUT_DOORS = 6,
                CARLOCK_LOCKED_BUT_CAN_BE_DAMAGED = 7
            };
        ]]
        Utils.SetVehicleProperties(vehicleEntity,vehicle.VehicleParms)
        vehicleEntityList[vehicle.VID] = vehicleEntity
    end)
end

RegisterNetEvent("wx_garage_system:updateVehicle",function(vehicleData)
    SpawnParkingVehicle(vehicleData)
end)

RegisterNetEvent("wx_garage_system:destroyVehicle",function(VID)
    SetEntityAsNoLongerNeeded(vehicleEntityList[VID])
    DeleteEntity(vehicleEntityList[VID])
    vehicleEntityList[VID] = nil
end)

RegisterNUICallback("quit", function(data,cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("PayAndUnlock", function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("wx_garage_system:Pay",data.VID,data.parkHours)
    local vehicleData = Callback.TriggerServerCallback("wx_garage_system:Unlock",data.VID,data.parkHours)
    vehicleData.VehicleParms = json.decode(vehicleData.VehicleParms)
    vehicleData.VehiclePosition = json.decode(vehicleData.VehiclePosition)
    vehicleData.VehiclePosition = vec3(vehicleData.VehiclePosition.x, vehicleData.VehiclePosition.y, vehicleData.VehiclePosition.z)

    local vehicleEntity = CreateVehicle(
        GetHashKey(vehicleData.VehicleModule),
        vehicleData.VehiclePosition.x,
        vehicleData.VehiclePosition.y,
        vehicleData.VehiclePosition.z,
        vehicleData.VehicleHeading,
        true,
        true
    )

    Utils.SetVehicleProperties(vehicleEntity,vehicleData.VehicleParms)
    local showPositionMarker = true
    Citizen.SetTimeout(8000,function()
        showPositionMarker = false
    end)
    Citizen.CreateThread(function()
        while showPositionMarker do
            Wait(1)
            if GetVehiclePedIsIn(PlayerPedId(),false) ~= vehicleEntity then
                Render.Marker.DrawMarker({
                    type = 0,
                    positionX = GetEntityCoords(vehicleEntity).x,
                    positionY = GetEntityCoords(vehicleEntity).y,
                    positionZ = GetEntityCoords(vehicleEntity).z+1.5,
                    scaleX = 1.2,
                    scaleY = 1.2,
                    scaleZ = 1.2,
                    colorR = 255,
                    colorG = 255,
                    colorB = 255,
                    alpha = 140,
                    jitterUpAndDown = true,
                    spin = true,
                })
            else
                break
            end
        end
    end)
end)


RegisterNUICallback("Pay", function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("wx_garage_system:Pay",data.VID,data.parkHours)
end)
RegisterNUICallback("Rename", function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("wx_garage_system:Rename",data.VID,data.NewName)
end)