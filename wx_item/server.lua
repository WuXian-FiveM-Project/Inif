AddEventHandler("RegisterItem",function(Table)
    local self = {}
    setmetatable(self, self)
    self.__newindex = self.__newindex
    self.__index = self
    assert(type(Table) == "table", "Table must be a table")

    assert(type(Table.ItemName) == "string", "Table.ItemName must be a string")
    self.ItemName = Table.ItemName
    self.ItemType = Table.ItemType
    assert(type(Table.ItemDensity) == "integer" or type(Table.ItemDensity) == "number", "Table.ItemDensity must be number or integer")
    self.ItemDensity = Table.ItemDensity
    self.ItemMaxDensity = Table.ItemMaxDensity or 10000000000000000
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
    self.CombineFunction = Table.CombineFunction or function() end
    self.TransferFunction = Table.TransferFunction or function() end
    self.IsEnableAntiCheat = Table.IsEnableAntiCheat or true
    table.insert(item_index,self.ItemName)


    item_list[self.ItemName] = self
end)

TriggerEvent("RegisterModule","Item",{
    GetItem = function()
        
    end
},true)

item_index = {} --[[data structure : index,item name]]
item_list = {} --[[data structure : item class]]
