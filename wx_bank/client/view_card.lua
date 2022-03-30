RegisterNetEvent("wx_bank:card:viewCard",function(bankCardData)
    SetNuiFocus(true,true)
    SendNUIMessage({
        type = "showBankCardView",
        cardData = bankCardData
    })
end)
