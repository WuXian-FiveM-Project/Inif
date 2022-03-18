local Player = exports.wx_module_system:RequestModule("Player")
local Utils = exports.wx_module_system:RequestModule("Utils")
TriggerEvent("RegisterItem",{
    ItemName = "bread",
    ItemShowName = "面包",
    ItemType = "food",
    ItemDescription = "面包[+30-40%饱腹感]",
    ItemDensity = 0.1,
    ItemModel = "prop_money_bag_01",
    ItemMaxDensity = 5000000,
    ItemMaxAmount = 500,
    ItemMaxUseAmount = 1,
    ItemMaxTransferAmount = 1000000000,
    ItemMaxThrowAmount = 1000000000,
    ItemMaxStack = 1000000000,
    --#region image
    ItemImage = "https://www.breadsecret.com/wp-content/uploads/2021/09/bread-secret-cheesy-stuffed-breadstick-503x503.jpg",
    --#endregion
    CanItemDrop = true,
    CanItemPickup = true,
    CanItemUse = true,
    CanItemTransfer = true,
    CanItemCombine = true,
    IsItemPhysicalAfterDrop = true,
    UseFunction = function(PlayerID,ItemAmount,AttachData,Reject)
        print(PlayerID)
        local a = Player.GetPlayer(PlayerID)
        a = a:Physiology()
        local addValue = Utils.GenerateRandomInt(30,40)
        if a.Physiology.Satiety.Get() + addValue < 100 then
            a.Physiology.Satiety.Add(addValue)
        else
            a = a:Notification()
            a.Notification.ShowNotification("吃不下了")
            Reject()
        end
    end,
    DropFunction = nil,
    PickupFunction = nil,
    StackFunction = nil,
    TransferFunction = nil,
    IsEnableAntiCheat = true,
})