Callback = exports.wx_module_system:RequestModule("Callback")

Callback.RegisterServerCallback("wx_inventory_ui:requestItemData", function(source)
    local Player = exports.wx_module_system:RequestModule("Player")
    local e = Player.GetPlayer(source)
    e = e:Inventory()
    local returnTable = {}
    for k,v in ipairs(e.Inventory.GetItems()) do
        table.insert(returnTable,{
            ItemShowName = v.ItemShowName,
            ItemName = v.ItemName,
            ItemDescription = v.ItemDescription,
            ItemMaxUseAmount = v.ItemMaxUseAmount,
            ItemMaxAmount = v.ItemMaxAmount,
            CanItemDrop = v.CanItemDrop,
            CanItemPickup = v.CanItemPickup,
            CanItemUse = v.CanItemUse,
            CanItemTransfer = v.CanItemTransfer,
            Amount = v.Amount,
            Density = v.Density,
        })
    end
    return returnTable
end)