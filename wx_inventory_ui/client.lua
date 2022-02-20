Callback = exports.wx_module_system:RequestModule("Callback")

local displayState = false

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustReleased(0, 58) then
            displayState = not displayState
            if displayState then
                local itemData = Callback.TriggerServerCallback("wx_inventory_ui:requestItemData")
                SetNuiFocus(true, true)
                SendNUIMessage({
                    type = "open",
                    item = itemData
                })
            else
                SetNuiFocus(false, false)
                SendNUIMessage({
                    type = "close"
                })
            end
        end
    end
end)