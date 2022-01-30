MySql = exports.wx_module_system:RequestModule("MySql")
Item = exports.wx_module_system:RequestModule("Item")
TriggerEvent("RegisterPlayerModule","Inventory",function(self)
    self.Inventory = {}

    ---get specific item in inventory
    ---@param itemName string specific item you want to get
    ---@return table item item class with itemTable.Amount itemTable.Density itemTable.AttachData itemTable.ID
    self.Inventory.GetItem = function(itemName)
        local value = MySql.Sync.Fetch("player_items","*",{
            {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
            {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
        })
        local itemTable = Item.GetItem(itemName)
        itemTable.Amount = value[1].ItemAmount
        itemTable.Density = value[1].ItemAmount
        itemTable.AttachData = json.decode(value[1].ItemAttachData)
        itemTable.ID = value[1].IID
        return itemTable
    end

    ---get all item in inventory
    ---@return table item table with item like {Inventory.GetItem(1),Inventory.GetItem(2),...}
    self.Inventory.GetItems = function()
        local value = MySql.Sync.Fetch("player_items","*",{
            {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
        })
        local Table = {}
        for k,v in pairs(value) do
            local itemTable = Item.GetItem(v.ItemName)
            itemTable.Amount = v.ItemAmount
            itemTable.Density = v .ItemAmount
            itemTable.AttachData = json.decode(v .ItemAttachData)
            itemTable.ID = v .IID
            table.insert(Table,itemTable)
        end
        return Table
    end
    ---get is item exist in inventory
    ---@param itemName string specific item you want to know if that exist
    ---@return boolean item item exist or not
    self.Inventory.IsItemExists = function(itemName)
        local value = MySql.Sync.Fetch("player_items","*",{
            {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
            {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
        })
        if type(value[1]) == "table" then
            return true
        else
            return false
        end
    end

    ---get max item can player hold
    ---@return number number max item can player hold
    self.Inventory.GetMaxItemCanHold = function()
        return MySql.Sync.Fetch("player","MaxItemCanHold",{
            {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
        })[1].MaxItemCanHold
    end

    ---get max density can player hold
    ---@return number item max density can player hold
    self.Inventory.GetMaxDensityCanHold = function()
        return MySql.Sync.Fetch("player","MaxDensityCanHold",{
            {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
        })[1].MaxDensityCanHold
    end





    self.Inventory.GiveItem = function(itemName,amount,attachData)
        if self.Inventory.IsItemExists(itemName) then
            local iteminfo = Item.GetItem(itemName)
            local before = self.Inventory.GetItem(itemName)

        end
    end
    return self
end)