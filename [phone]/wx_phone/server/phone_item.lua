local MySql = exports.wx_module_system:RequestModule("MySql")

Citizen.CreateThread(function()
    local phoneList = MySql.Sync.Query("SELECT * FROM player_phone",{})
    for index, value in ipairs(phoneList) do
        TriggerEvent("RegisterItem", {
            ItemName = value.PID.."_phone",
            ItemShowName = "手机",
            ItemType = "工具",
            ItemDescription = "行动电话，又称手提式电话机或手提电话，简称手机",
            ItemDensity = 100,
            ItemModel = "prop_phone_proto",
            ItemMaxDensity = 50000000000,
            ItemMaxAmount = 1,
            ItemMaxUseAmount = 1,
            ItemMaxTransferAmount = 1,
            ItemMaxThrowAmount = 1,
            ItemMaxStack = 1,
            ItemImage = "https://www.apple.com/v/iphone-13-pro/f/images/overview/design/finishes_1_alpine_green__bxgqurawflau_large.jpg",
            CanItemDrop = true,
            CanItemPickup = true,
            CanItemUse = true,
            CanItemTransfer = true,
            CanItemCombine = true,
            IsItemPhysicalAfterDrop = true,
            UseFunction = function(PlayerID,ItemAmount,AttachData,Reject)
                Reject()
                local phoneData = MySql.Sync.Query("SELECT * FROM player_phone WHERE PID = ?",{
                    value.PID
                })[1]
                phoneData.PhoneSetting = json.decode(phoneData.PhoneSetting)
                phoneData.PhoneApps = json.decode(phoneData.PhoneApps)
                TriggerClientEvent("wx_phone:usePhone",PlayerID,phoneData)
            end,
            DropFunction = nil,
            PickupFunction = nil,
            StackFunction = nil,
            TransferFunction = nil,
            IsEnableAntiCheat = true,
        })
    end
end)
