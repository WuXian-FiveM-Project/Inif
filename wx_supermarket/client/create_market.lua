local refreshFrequency = 10000
local Render = exports.wx_module_system:RequestModule("Render")
local Notification = exports.wx_module_system:RequestModule("Notification")
local Callback = exports.wx_module_system:RequestModule("Callback")

Citizen.CreateThread(function()
    while true do
        local pool = GetGamePool("CObject")
        for _ ,entity in ipairs(pool) do
            if string.find(GetEntityArchetypeName(entity), "prop_till_") then
                Citizen.CreateThread(function()
                    local show = true
                    local blip
                    Citizen.CreateThread(function()
                        local entity_coords = GetEntityCoords(entity)
                        blip = AddBlipForEntity(entity)
                        SetBlipSprite(blip, 52)
                        SetBlipColour(blip, 25)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("附近的便利店")
                        EndTextCommandSetBlipName(blip)
                        while show do
                            Wait(0)
                            Render.Marker.DrawMarker({
                                type = 1--[[integer:required]],
                                positionX = entity_coords.x --[[number:required]],
                                positionY = entity_coords.y --[[number:required]],
                                positionZ = entity_coords.z -1.0 --[[number:required]],
                                rotationX = 0.0 --[[number]],
                                rotationY = 0.0 --[[number]],
                                rotationZ = 0.0 --[[number]],
                                scaleX = 2.5 --[[number:required]],
                                scaleY = 2.5 --[[number:required]],
                                scaleZ = 1.0 --[[number:required]],
                                colorR = 50 --[[number:required]],
                                colorG = 255 --[[number:required]],
                                colorB = 50 --[[number:required]],
                                alpha = 150 --[[number]],
                                jitterUpAndDown = false --[[boolean]],
                                faceToCamera = false --[[boolean]],
                                spin = true --[[boolean]],
                                onEnter = function()
                                    Notification.ShowHelpNotification("按~INPUT_PICKUP~购买东西")
                                    if IsControlJustPressed(0,38) then
                                        SetNuiFocus(true, true)
                                        SendNUIMessage({
                                            type = "showShop",
                                            shopItem = Callback.TriggerServerCallback("wx_supermarket:getShopItem")
                                        })
                                    end
                                end --[[function]]
                            })
                        end
                    end)

                    Citizen.SetTimeout(refreshFrequency - 10 ,function()
                        show = false
                        RemoveBlip(blip)
                    end)
                end)
            end
        end
        Wait(refreshFrequency)
    end
end)