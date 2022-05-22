local MySql = exports.wx_module_system:RequestModule("MySql")

Citizen.CreateThread(function()
    local phoneList = MySql.Sync.Query("SELECT * FROM player_phone")
    for k, v in ipairs(phoneList) do
        ---@type Item
        local item = {
            ItemName        = v.PID .. "_phone",
            ItemShowName            = "手机",
            ItemType                = "tools",
            ItemDescription         = "手机是一种无线手持设备",
            ItemDensity             = 0.1,
            ItemModel               = "prop_amb_phone",
            ItemMaxDensity          = 100000000,
            ItemMaxUseAmount        = 100000000, --[[物品单次最大使用数]]
            ItemMaxThrowAmount      = 100000000, --[[物品单次最大丢弃数]]
            ItemMaxTransferAmount   = 100000000, --[[物品单次最大转移数]]
            ItemImage               = "https://www.apple.com/v/iphone-13-pro/f/images/overview/design/finishes_1_alpine_green__bxgqurawflau_large.jpg", --[[支持base64  基于html src ]]
            ItemMaxAmount           = 1,
            ItemMaxStack            = 1,
            CanItemDrop             = true,
            CanItemPickup           = true,
            CanItemUse              = true,
            CanItemTransfer         = true,
            CanItemCombine          = true,
            IsItemPhysicalAfterDrop = true,
            UseFunction             = function(PlayerID,ItemAmount,AttachData,Reject)
                --TODO: implement app module and pass to client
                Reject()
                local phone = phoneModule.GetPhone(v.PID)
                if phone == nil then return end
                local appList = {}
                for pk, pv in pairs(table.pack(phone.PhoneApps.Get())[1]) do
                    local app = AppModule.GetApp(pv)
                    table.insert(appList, app)
                end
                
                local result = {
                    PID                  = v.PID,
                    PhonePassword        = phone.PhonePassword.Get(),
                    PhoneModule          = phone.PhoneModule.Get(),
                    PhoneSetting         = phone.PhoneSetting.Get(),
                    PhoneApps            = appList,
                    PhoneData            = phone.PhoneData.Get(),
                    PhoneRegisterDate    = phone.PhoneRegisterDate.Get(),
                    PhoneMaxCapacity     = phone.PhoneMaxCapacity.Get(),
                    PhoneCurrentCapacity = phone.PhoneCurrentCapacity.Get(),
                }
                TriggerClientEvent("wx_phone:showPhone", PlayerID, result)
            end,
            IsEnableAntiCheat       = true,
        }
        TriggerEvent("RegisterItem", item)
    end
end)