local Callback = exports.wx_module_system:RequestModule("Callback")
local MySql = exports.wx_module_system:RequestModule("MySql")
local Player = exports.wx_module_system:RequestModule("Player")

Callback.RegisterServerCallback("wx_supermarket:getShopItem",function(src)
    local result = MySql.Sync.Query("SELECT * FROM shop_item",{})
    for i,v in ipairs(result) do
        if result[i].ItemOnSale == 1 then
            result[i].ItemOnSale = true
        else
            result[i].ItemOnSale = false
        end

        if result[i].ItemCanSales == 1 then
            result[i].ItemCanSales = true
        else
            result[i].ItemCanSales = false
        end
    end
    return result
end)

Callback.RegisterServerCallback("wx_supermarket:getCurrentMoney",function(src)
    return Player.GetPlayer(src):Inventory().Inventory.GetItem("money").Amount or 0
end)

Callback.RegisterServerCallback("wx_supermarket:buyItem",function(src,cartItem)
    local player = Player.GetPlayer(src)
    player = player:Inventory()
    local totalPrice = 0
    for i,v in ipairs(cartItem) do
        if v.ItemOnSale then
            totalPrice = totalPrice + (v.ItemDiscountPrice * v.ItemCount)
        else
            totalPrice = totalPrice + (v.ItemPrice * v.ItemCount)
        end
    end

    if player.Inventory.RemoveItem("money",totalPrice) then
        for i,v in ipairs(cartItem) do
            print(v.ItemCount,v.ItemName,json.encode(v))
            player.Inventory.GiveItem(v.ItemName,v.ItemCount)
        end
    else
        DropPlayer(src, "已触发服务器事件反作弊，代码位置：wx_supermarket/server/server_market_callback.lua:buyItem(42:42)")
    end
end)