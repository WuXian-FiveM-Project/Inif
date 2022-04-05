local Callback = exports.wx_module_system:RequestModule("Callback")

RegisterNUICallback("closeShop", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("buy", function(data,cb)
    local money = Callback.TriggerServerCallback("wx_supermarket:getCurrentMoney")
    local totalPrice = 0

    for i,v in ipairs(data.cartItem) do
        if v.ItemOnSale then
            totalPrice = totalPrice + (v.ItemDiscountPrice * v.ItemCount)
        else
            totalPrice = totalPrice + (v.ItemPrice * v.ItemCount)
        end
    end

    if money >= totalPrice then
        cb(true)
        Callback.TriggerServerCallback("wx_supermarket:buyItem",data.cartItem)
    else
        cb(false)
    end
end)