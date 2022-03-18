local Callback = exports.wx_module_system:RequestModule("Callback")
local Player = exports.wx_module_system:RequestModule("Player")


Callback.RegisterServerCallback("wx_inventory_ui:getInventory",function(source)
    local player = Player.GetPlayer(source)
    player = player:Inventory()
    local returnTable = {}
    print(player.Inventory.GetItems())
    
    for k,v in ipairs(player.Inventory.GetItems()) do
        table.insert(returnTable,{
            displayName = v.ItemShowName,
            currentAmount = v.Amount,
            maxAmount = v.ItemMaxAmount,
            maxUseAmount = v.ItemMaxUseAmount,
            maxTransferAmount = v.ItemMaxTransferAmount,
            maxThrowAmount = v.ItemMaxThrowAmount,
            image = v.ItemImage,
            itemName = v.ItemName,
            itemDescription = v.ItemDescription,
            canUse = v.CanItemUse,
            canThrow = v.CanItemDrop,
            canTransfer = v.CanItemTransfer,
        })
    end
    return returnTable
end)

RegisterNetEvent('wx_inventory_ui:useItem',function(itemName,amount)
    local src = source
    local player = Player.GetPlayer(src)
    player = player:Inventory()
    player.Inventory.UseItem(itemName,amount)
end)

RegisterNetEvent('wx_inventory_ui:throwItem',function(itemName,amount)
    local src = source
    local player = Player.GetPlayer(src)
    player = player:Inventory()
    print(itemName,amount)
    player.Inventory.DropItem(itemName,amount)
end)
