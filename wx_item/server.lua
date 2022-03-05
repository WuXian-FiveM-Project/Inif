AddEventHandler("RegisterItem",function(Table)
    local self = {}
    setmetatable(self, self)
    self.__newindex = self.__newindex
    self.__index = self
    --#region Properties set
    assert(type(Table) == "table", "Table must be a table")
    assert(type(Table.ItemName) == "string", "Table.ItemName must be a string")
    self.ItemName = Table.ItemName
    self.ItemShowName = Table.ItemShowName or self.ItemName
    self.ItemType = Table.ItemType
    self.ItemDescription = Table.ItemDescription or self.ItemName
    assert(type(Table.ItemDensity) == "integer" or type(Table.ItemDensity) == "number", "Table.ItemDensity must be number or integer")
    self.ItemDensity = Table.ItemDensity
    self.ItemModel = Table.ItemModel or "prop_physics"
    self.ItemMaxDensity = Table.ItemMaxDensity or 10000000000000000
    self.ItemMaxUseAmount = Table.ItemMaxUseAmount or 10000000000000000 --[[物品单次最大使用数]]
    self.ItemMaxThrowAmount = Table.ItemMaxThrowAmount or 10000000000000000 --[[物品单次最大丢弃数]]
    self.ItemMaxTransferAmount = Table.ItemMaxTransferAmount or 10000000000000000 --[[物品单次最大转移数]]
    self.ItemImage = Table.ItemImage or ""
    self.ItemMaxAmount = Table.ItemMaxAmount or 10000000000000000
    self.ItemMaxStack = Table.ItemMaxStack or 10000000000000000
    assert(type(Table.CanItemDrop) == "boolean", "Table.CanItemDrop must be a boolean")
    self.CanItemDrop = Table.CanItemDrop
    assert(type(Table.CanItemPickup) == "boolean", "Table.CanItemPickup must be a boolean")
    self.CanItemPickup = Table.CanItemPickup
    assert(type(Table.CanItemUse) == "boolean", "Table.CanItemUse must be a boolean")
    self.CanItemUse = Table.CanItemUse
    assert(type(Table.CanItemTransfer) == "boolean", "Table.CanItemTransfer must be a boolean")
    self.CanItemTransfer = Table.CanItemTransfer
    assert(type(Table.CanItemCombine) == "boolean", "Table.CanItemCombine must be a boolean")
    self.CanItemCombine = Table.CanItemCombine
    self.IsItemPhysicalAfterDrop = Table.IsItemPhysicalAfterDrop or true
    self.UseFunction = Table.UseFunction or function() end
    self.DropFunction = Table.DropFunction or function() end
    self.PickupFunction = Table.PickupFunction or function() end
    self.StackFunction = Table.StackFunction or function() end
    self.TransferFunction = Table.TransferFunction or function() end
    self.IsEnableAntiCheat = Table.IsEnableAntiCheat or true
    --#endregion
    table.insert(item_index,self.ItemName)
    item_list[self.ItemName] = self
end)

--#region Item exsample
local t = {
    ItemName = nil,
    ItemShowName = nil,
    ItemType = nil,
    ItemDescription = nil,
    ItemDensity = nil,
    ItemModel = nil,
    ItemMaxDensity = nil,
    ItemMaxUseAmount = nil, --[[物品单次最大使用数]]
    ItemMaxThrowAmount = nil, --[[物品单次最大丢弃数]]
    ItemMaxTransferAmount = nil, --[[物品单次最大转移数]]
    ItemImage = nil, --[[支持base64  基于html src ]]
    ItemMaxAmount = nil,
    ItemMaxStack = nil,
    CanItemDrop = nil,
    CanItemPickup = nil,
    CanItemUse = nil,
    CanItemTransfer = nil,
    CanItemCombine = nil,
    IsItemPhysicalAfterDrop = nil,
    UseFunction = nil,
    DropFunction = nil,
    PickupFunction = nil,
    StackFunction = nil,
    TransferFunction = nil,
    IsEnableAntiCheat = nil,
}
--#endregion

TriggerEvent("RegisterModule","Item",{
    ---get item class or structure
    ---@param itemName string @item name
    ---@return table table class or structure
    GetItem = function(itemName)
        return item_list[itemName]
    end
},true)

item_index = {} --[[data structure : index,item name]]
item_list = {} --[[data structure : item class]]


TriggerEvent("RegisterItem",{
    ItemName = "water",
    ItemShowName = "TEST ITEM",
    ItemType = "test",
    ItemDescription = "test item description yea!",
    ItemDensity = 100,
    ItemModel = "prop_water_bottle",
    ItemMaxDensity = 50000000000,
    ItemMaxAmount = 100,
    ItemMaxUseAmount = 2,
    ItemMaxTransferAmount = 10,
    ItemMaxThrowAmount = 5555,
    ItemMaxStack = 64,
    ItemImage = "data:image/jpeg;base64,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",
    CanItemDrop = true,
    CanItemPickup = true,
    CanItemUse = true,
    CanItemTransfer = true,
    CanItemCombine = true,
    IsItemPhysicalAfterDrop = true,
    UseFunction = function(PlayerID,ItemAmount,AttachData,Reject)
        -- Reject 是一个函数 当他传入的时候，如果出现一些情况 要取消这次使用的话就直接调用Reject()不要CancelEvent()
        print("player："..PlayerID.." use item：test_item with amount："..ItemAmount.." with attach data："..json.encode(AttachData))
        Wait(1000)
        -- Reject()
        -- print("oh no the use event was rejected")
    end,
    DropFunction = nil,
    PickupFunction = nil,
    StackFunction = nil,
    TransferFunction = nil,
    IsEnableAntiCheat = true,
})

TriggerEvent("RegisterItem",{
    ItemName = "bread",
    ItemShowName = "TEST ITEM",
    ItemType = "test",
    ItemDescription = "test item description yea!",
    ItemDensity = 10,
    ItemModel = "ng_proc_food_burg01a",
    ItemMaxDensity = 50000000000,
    ItemMaxUseAmount = 2,
    ItemMaxAmount = 100,
    ItemMaxStack = 64,
    CanItemDrop = true,
    CanItemPickup = true,
    CanItemUse = true,
    CanItemTransfer = true,
    CanItemCombine = true,
    IsItemPhysicalAfterDrop = true,
    UseFunction = function(PlayerID,ItemAmount,AttachData,Reject)
        -- Reject 是一个函数 当他传入的时候，如果出现一些情况 要取消这次使用的话就直接调用Reject()不要CancelEvent()
        print("player："..PlayerID.." use item：test_item with amount："..ItemAmount.." with attach data："..json.encode(AttachData))
        -- Reject()
        -- print("oh no the use event was rejected")
    end,
    DropFunction = nil,
    PickupFunction = nil,
    StackFunction = nil,
    TransferFunction = nil,
    IsEnableAntiCheat = true,
})