MySql = exports.wx_module_system:RequestModule("MySql")
Console = exports.wx_module_system:RequestModule("Console")

TriggerEvent("RegisterPlayerModule","Inventory",function(self) --self 是隐式参数 self = Player.GetPlayer()
    self.Inventory = {}
    
    self.Inventory.GetItems = function()
        local value = MySql.Sync.Fetch("player_items","*",{{Method="AND",Operator="=",Column="SteamID",Value=self.SteamID.Get()}})
        for k, _ in pairs(value) do
            value[k].ItemAttachData = json.decode(value[k].ItemAttachData)
        end
        return value
    end

    self.Inventory.GetItem = function(itemName)
        local value = MySql.Sync.Fetch("player_items","*",{{Method="AND",Operator="=",Column="SteamID",Value=self.SteamID.Get()},{Method="AND",Operator="=",Column="ItemName",Value=itemName}})
        value[1].ItemAttachData = json.decode(value[1].ItemAttachData)
        value = value[1]
        return value
    end

    self.Inventory.GiveItem = function(itemName,amount,isForce,attachData)
        
    end

    self.Inventory.RemoveItem = function(itemName,amount)

    end

    self.Inventory.IsHasItem = function(itemName)

    end
    
    self.Inventory.GetMaxDensityCanHold = function()

    end
    
    self.Inventory.GetMaxItemCanHold = function()

    end

    return self
end)