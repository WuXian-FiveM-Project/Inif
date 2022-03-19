local GARAGE_POSITION <const> = {
    {
        GID  =1,
        Blip = {
            Coord = vec3(227.63, -790.78, 31.89),
            Sprite = 524,
            Color = 15,
            Scale = 1.2,
            Name = "中庭车库"
        },
        TakeCarMarker = {
            Type = 36,
            Coord = vec3(213.25,-809.13,30.5),
            Color = {
                R = 108,
                G = 184,
                B = 217,
                A = 150
            },
            Scale = vec3(1.0, 1.0, 1.0),
        },
        DepositCarMarker = {
            Type = 1,
            Coord = vec3(208.99,-808.43,30),
            Color = {
                R = 232,
                G = 107,
                B = 107,
                A = 150
            },
            Scale = vec3(5.0, 5.0, 1.0),
        },
        MaxVehiclesCanStore = (16*5) + 17 + (6*2) --下层露天 16 *5 个车位 下层室内 6*2 个车位 上层室外 17 个车位
    }
}

Citizen.CreateThread(function()
    local Render = exports.wx_module_system:RequestModule("Render")
    for index,value in ipairs(GARAGE_POSITION) do
        local Blip = AddBlipForCoord(
            value.Blip.Coord.x --[[ number ]], 
		    value.Blip.Coord.y --[[ number ]], 
		    value.Blip.Coord.z --[[ number ]]
	    )
        SetBlipSprite(Blip --[[ Blip ]], value.Blip.Sprite --[[ integer ]])
        SetBlipScale(Blip --[[ Blip ]], value.Blip.Scale --[[ number ]])
        SetBlipColour(Blip, value.Blip.Color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(value.Blip.Name)
        EndTextCommandSetBlipName(Blip)

        -- TakeCarMarker
        Citizen.CreateThread(function()
            while true do
                DoorSystemSetDoorState(-1116041313, true)
                Wait(1)
                Render.Marker.DrawMarker(
                    {
                        type = value.TakeCarMarker.Type --[[integer:required]],
                        positionX = value.TakeCarMarker.Coord.x --[[number:required]],
                        positionY = value.TakeCarMarker.Coord.y --[[number:required]],
                        positionZ = value.TakeCarMarker.Coord.z --[[number:required]],
                        scaleX = value.TakeCarMarker.Scale.x --[[number:required]],
                        scaleY = value.TakeCarMarker.Scale.y --[[number:required]],
                        scaleZ = value.TakeCarMarker.Scale.z --[[number:required]],
                        colorR = value.TakeCarMarker.Color.R --[[number:required]],
                        colorG = value.TakeCarMarker.Color.G --[[number:required]],
                        colorB = value.TakeCarMarker.Color.B --[[number:required]],
                        alpha = value.TakeCarMarker.Color.A --[[number]],
                        onEnter = function()
                            exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("按下 ~INPUT_CONTEXT~ 取车",true)
                            if IsControlPressed(0, 38) then
                                SetNuiFocus(true, true)
                                SendNUIMessage({
                                    type = "openGarage",
                                    garage = index
                                })
                            end
                        end,
                    }
                )
                Render.Light.DrawSpotLight(
                    {
                        type = value.TakeCarMarker.Type --[[integer:required]],
                        positionX = value.TakeCarMarker.Coord.x --[[number:required]],
                        positionY = value.TakeCarMarker.Coord.y --[[number:required]],
                        positionZ = value.TakeCarMarker.Coord.z+2.0 --[[number:required]],
                        aimmingCoordX = value.TakeCarMarker.Coord.x --[[number:required]],
                        aimmingCoordY = value.TakeCarMarker.Coord.y --[[number:required]],
                        aimmingCoordZ = value.TakeCarMarker.Coord.z --[[number:required]],
                        colorR = value.TakeCarMarker.Color.R --[[number:required]],
                        colorG = value.TakeCarMarker.Color.G --[[number:required]],
                        colorB = value.TakeCarMarker.Color.B --[[number:required]],
                        distance = 10.0,
                        brightness = 2.0,
                        roundness = 10.0,
                        radius = 500.0,
                        falloff = 10.0,
                    }
                )
            end
        end)

        -- DepositCarMarker
        Citizen.CreateThread(function()
            while true do
                Wait(1)
                Render.Marker.DrawMarker(
                    {
                        type = value.DepositCarMarker.Type --[[integer:required]],
                        positionX = value.DepositCarMarker.Coord.x --[[number:required]],
                        positionY = value.DepositCarMarker.Coord.y --[[number:required]],
                        positionZ = value.DepositCarMarker.Coord.z --[[number:required]],
                        scaleX = value.DepositCarMarker.Scale.x --[[number:required]],
                        scaleY = value.DepositCarMarker.Scale.y --[[number:required]],
                        scaleZ = value.DepositCarMarker.Scale.z --[[number:required]],
                        colorR = value.DepositCarMarker.Color.R --[[number:required]],
                        colorG = value.DepositCarMarker.Color.G --[[number:required]],
                        colorB = value.DepositCarMarker.Color.B --[[number:required]],
                        alpha = value.DepositCarMarker.Color.A --[[number]],
                        onEnter = function()
                            exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("按下 ~INPUT_CONTEXT~ 停车",true)
                            if IsControlPressed(0, 38) then
                                if GetVehiclePedIsIn(GetPlayerPed(-1) --[[ Ped ]], false --[[ boolean ]]) == 0 then
                                    exports.wx_module_system:RequestModule("Notification").ShowNotification("你不在载具上面")
                                    return
                                end
                                exports.wx_module_system:RequestModule("Notification").ShowNotification("已开始扣费，请停车后按下E键保存位置")
                                Wait(100)
                                while true do
                                    Wait(1)
                                    exports.wx_module_system:RequestModule("Notification").ShowHelpNotification("按下 ~INPUT_CONTEXT~ 保存位置",true)
                                    if IsControlPressed(0, 38) then
                                        exports.wx_module_system:RequestModule("Notification").ShowNotification("已保存位置")
                                        local Utils = exports.wx_module_system:RequestModule("Utils")
                                        TriggerServerEvent(
                                            "wx_garage:depositCar",
                                            GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1),false))),
                                            value.GID,
                                            GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)),
                                            Utils.GetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1),false))
                                        )
                                        break
                                    end
                                end
                            end
                        end,
                    }
                )
                Render.Light.DrawSpotLight(
                    {
                        type = value.DepositCarMarker.Type --[[integer:required]],
                        positionX = value.DepositCarMarker.Coord.x --[[number:required]],
                        positionY = value.DepositCarMarker.Coord.y --[[number:required]],
                        positionZ = value.DepositCarMarker.Coord.z+2.0 --[[number:required]],
                        aimmingCoordX = value.DepositCarMarker.Coord.x --[[number:required]],
                        aimmingCoordY = value.DepositCarMarker.Coord.y --[[number:required]],
                        aimmingCoordZ = value.DepositCarMarker.Coord.z --[[number:required]],
                        colorR = value.DepositCarMarker.Color.R --[[number:required]],
                        colorG = value.DepositCarMarker.Color.G --[[number:required]],
                        colorB = value.DepositCarMarker.Color.B --[[number:required]],
                        distance = 10.0,
                        brightness = 2.0,
                        roundness = 10.0,
                        radius = 500.0,
                        falloff = 10.0,
                    }
                )
            end
        end)
    end
end)

RegisterNetEvent("wx_garage:setVehicleProps",function(props)
    print("setVehicleProps")
    local Utils = exports.wx_module_system:RequestModule("Utils")
    local frin = false
    for _,v in ipairs(props) do
        print(json.encode(v), v.Vehicle,json.encode(v.Props))
        Utils.SetVehicleProperties(v.Vehicle,v.Props)
        if v == 0 then --防止冷启动时 载具不加载到客户端上
            frin = true
        end
    end
    if frin then
        RegisterNetEvent("wx_garage:frBoost")
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent("wx_garage_system:requestVehicleProp")
end)