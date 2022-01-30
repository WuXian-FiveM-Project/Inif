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
    self.ItemMaxDensity = Table.ItemMaxDensity or 10000000000000000
    self.ItemMaxUseAmount = Table.ItemMaxUseAmount or 10000000000000000 --[[物品单次最大使用数]]
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
    ItemMaxDensity = nil,
    ItemMaxUseAmount = nil, --[[物品单次最大使用数]]
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
        assert(type(item_list[itemName]) == "table","item（"..itemName.."） not exist")
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
        print("player："..PlayerID.." use item：test_item with amount："..ItemAmount.." with attach data："..AttachData)
        Reject()
        print("oh no the use event was rejected")
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
        print("player："..PlayerID.." use item：test_item with amount："..ItemAmount.." with attach data："..AttachData)
        Reject()
        print("oh no the use event was rejected")
    end,
    DropFunction = nil,
    PickupFunction = nil,
    StackFunction = nil,
    TransferFunction = nil,
    IsEnableAntiCheat = true,
})