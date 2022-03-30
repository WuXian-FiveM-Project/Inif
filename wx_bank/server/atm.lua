local Callback = exports.wx_module_system:RequestModule("Callback")
local MySql = exports.wx_module_system:RequestModule("MySql")
local Player = exports.wx_module_system:RequestModule("Player")


Callback.RegisterServerCallback("wx_bank:getCardList",function(src)
    local playerInventoryCard = MySql.Sync.Query("SELECT * FROM player_items WHERE SteamID=?",{
        GetPlayerIdentifier(src)
    })
    local playerInventoryCardList = {} --BID list
    for _,v in pairs(playerInventoryCard) do
        if string.find(v.ItemName, "_bank_card") then
            local d = string.gsub(v.ItemName, "_bank_card","")
            table.insert(playerInventoryCardList,d)
        end
    end
    local allCard = {}
    for _,v in pairs(playerInventoryCardList) do
        table.insert(allCard,
            MySql.Sync.Query("SELECT *,ROUND(UNIX_TIMESTAMP(CardExpiryDate) * 1000) AS CardExpiryDate FROM bank_account WHERE BID=?",
            {
                v
            })[1]
        )
    end
    return allCard
end)

Callback.RegisterServerCallback("wx_bank:getMoney",function(src)
    return Player.GetPlayer(src):Inventory().Inventory.GetItem("money").ItemAmount or 0
end)

Callback.RegisterServerCallback("wx_bank:takeMoney",function(src,BID,amount)
    local Card = exports.wx_module_system:RequestModule("BankCard")
    local playerCard = Card.GetBankCardViaBID(BID)
    local player = Player.GetPlayer(src)
    player = player:Inventory()
    local result = playerCard.CardBalance.Remove(amount,false)
    if result then
        player.Inventory.GiveItem("money",amount)
        return true
    else
        return false
    end
end)

Callback.RegisterServerCallback("wx_bank:storeMoney",function(src,BID,amount)
    local Card = exports.wx_module_system:RequestModule("BankCard")
    local playerCard = Card.GetBankCardViaBID(BID)
    local player = Player.GetPlayer(src)
    player = player:Inventory()
    local result = player.Inventory.RemoveItem("money",amount)
    if result then
        playerCard.CardBalance.Add(amount)
        return true
    else
        return false
    end
end)

function ParseCardID(cardID)
    local result = ""
    for i = 1, #cardID do
        if i == 5 or i == 9 or i == 13 then
            result = result.." "..cardID:sub(i,i)
        else
            result = result..cardID:sub(i,i)
        end
    end
    return result
end

Callback.RegisterServerCallback("wx_bank:tradeMoney",function(src,BID,targetCardID,amount)
    local Card = exports.wx_module_system:RequestModule("BankCard")
    local selfCard = Card.GetBankCardViaBID(BID)
    targetCardID = ParseCardID(targetCardID)
    local targetCard = Card.GetBankCardViaCardID(targetCardID)
    local result = selfCard.CardBalance.Remove(amount,false)
    if result then
        targetCard.CardBalance.Add(amount)
        for _,v in pairs(GetPlayers()) do
            if GetPlayerIdentifier(v) == targetCard.CardOwnerSteamID.Get() then
                local targerPlayer = Player.GetPlayer(v)
                targerPlayer = targerPlayer:Notification()
                targerPlayer.Notification.ShowNotification("~g~您收到一笔"..amount.."元的转账来自"..selfCard.CardHolderFirstName.Get()..selfCard.CardHolderSecondName.Get())
            end
        end
        return true
    else
        return false
    end
end)