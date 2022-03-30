local Callback = exports.wx_module_system:RequestModule("Callback")
RegisterNUICallback("tradeMoney", function(data,cb)
    local BID = data.BID
    local targetCardID = data.targetCardID
    local amount = data.amount
    Callback.TriggerServerCallback("wx_bank:tradeMoney", BID, targetCardID, amount)
end)

RegisterNUICallback("takeMoney", function(data,cb)
    local BID = data.BID
    local amount = data.amount
    local result = Callback.TriggerServerCallback("wx_bank:takeMoney",BID,amount)
    if result then
        exports.wx_module_system:RequestModule("Notification").ShowNotification("~g~已成功取出"..amount.."元")
    else
        exports.wx_module_system:RequestModule("Notification").ShowNotification("~r~取款失败")
    end
end)

RegisterNUICallback("storeMoney", function(data,cb)
    local BID = data.BID
    local amount = data.amount
    local result = Callback.TriggerServerCallback("wx_bank:storeMoney",BID,amount)
    if result then
        exports.wx_module_system:RequestModule("Notification").ShowNotification("~g~已成功存入"..amount.."元")
    else
        exports.wx_module_system:RequestModule("Notification").ShowNotification("~r~存款失败")
    end
end)

RegisterNUICallback("disableCursur", function(data,cb)
    SetNuiFocus(false,false)
end)