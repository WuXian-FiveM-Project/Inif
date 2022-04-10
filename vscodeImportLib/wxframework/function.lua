exports = {}
exports.wx_module_system  = {}

---get module
---@param moduleName string moduleName
---@return table module
function exports.wx_module_system:RequestModule (moduleName)
    if moduleName == "Callback" then
        return
        {
            ---trigger server callback
            ---@param eventName string
            ---@param ... any
            ---@return any
            TriggerServerCallback = function (eventName,...)
                return ...
            end,
            ---trigger client callback
            ---@param eventName string callback name
            ---@param playerID integer player src
            ---@param ... any parameters
            ---@return any
            TriggerCientCallback = function (eventName,playerID,...)
                return ...
            end,
            ---register a server callback
            ---@param eventName string callback name
            ---@param callback function{string,string} callback function
            RegisterServerCallback = function (eventName,callback)
            end,
            RegisterClientCallback = function (eventName,callback)
            end,
        }
    elseif moduleName == "Player" then
        ---@class InventoryItem
        InventoryItem = {
            ItemName                = "",
            ItemShowName            = "",
            ItemType                = "",
            ItemDescription         = "",
            ItemDensity             = 0.0,
            ItemModel               = "",
            ItemMaxDensity          = 0.0,
            ItemMaxUseAmount        = 0,              --[[物品单次最大使用数]]
            ItemMaxThrowAmount      = 0,              --[[物品单次最大丢弃数]]
            ItemMaxTransferAmount   = 0,              --[[物品单次最大转移数]]
            ItemImage               = "",             --[[支持base64  基于html src ]]
            ItemMaxAmount           = 0,
            ItemMaxStack            = 0,
            CanItemDrop             = false,
            CanItemPickup           = false,
            CanItemUse              = false,
            CanItemTransfer         = false,
            CanItemCombine          = false,
            IsItemPhysicalAfterDrop = false,
            UseFunction             = function() end,
            DropFunction            = function() end,
            PickupFunction          = function() end,
            StackFunction           = function() end,
            TransferFunction        = function() end,
            IsEnableAntiCheat       = false,
            Amount                  = 0.0,
            Density                 = 0.0,
            ItemAmount              = 0,
            AttachData              = {},
            ID                      = 0,
            IID                     = 0
        }
        return {
            
            GetPlayer = function(PlayerID)
                local self = {}
                setmetatable(self, self)
                self.cache = {
                    PID = nil,
                    SteamID = nil,
                    License = nil,
                    Discord = nil,
                    IP = nil
                }

                self.__newindex = self.__newindex
                self.__index = self

                self.source = PlayerID

                self.PlayerID = {
                    Get = function()
                        return self.source
                    end
                }
                self.SteamID = {
                    Get = function()
                        if type(self.cache.SteamID) == "nil" then
                            for _, v in pairs(GetPlayerIdentifiers(self.source)) do
                                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                                    self.cache.SteamID = v
                                end
                            end
                        end
                        return self.cache.SteamID
                    end
                }
                self.License = {
                    Get = function()
                        if type(self.cache.License) == "nil" then
                            for _, v in pairs(GetPlayerIdentifiers(self.source)) do
                                if string.sub(v, 1, string.len("license:")) == "license:" then
                                    self.cache.License = v
                                end
                            end
                        end
                        return self.cache.License
                    end
                }
                self.Discord = {
                    Get = function()
                        if type(self.cache.Discord) == "nil" then
                            for _, v in pairs(GetPlayerIdentifiers(self.source)) do
                                if string.sub(v, 1, string.len("discord:")) == "discord:" then
                                    self.cache.Discord = v
                                end
                            end
                        end
                        return self.cache.Discord
                    end
                }
                self.IP = {
                    Get = function()
                        if type(self.cache.IP) == "nil" then
                            for _, v in pairs(GetPlayerIdentifiers(self.source)) do
                                if string.sub(v, 1, string.len("ip:")) == "ip:" then
                                    self.cache.IP = v
                                end
                            end
                        end
                        return self.cache.IP
                    end
                }
                self.SteamName = {
                    Get = function()
                        return GetPlayerName(self.source)
                    end
                }
                self.PID = {
                    Get = function()
                        if type(self.cache.PID) == "nil" then
                            self.cache.PID =
                                exports.wx_module_system:RequestModule("MySql").Sync.Query("SELECT PID FROM player WHERE SteamID=?",{
                                    self.SteamID.Get()
                                })[1].SteamID

                            --     exports.wx_module_system:RequestModule("MySql").Sync.Fetch(
                            --     "player",
                            --     {"PID"},
                            --     {
                            --         {Method = "And", Column = "SteamID", Value = self.SteamID.Get(), Operator = "="}
                            --     }
                            -- )[1].PID
                        end
                        return self.cache.PID
                    end
                }

                for _, v in ipairs(modulelist) do
                    self[v] = playerobj[v]
                    -- print(v)
                end

                self.Config = {}

                ---set/insert config
                ---@param key any
                ---@param value any
                self.Config.Set = function(key,value)
                    assert(type(key) == "string","key must be string")
                    if type(value) == "table" then
                        value = json.encode(value)
                    end
                    value = tostring(value)
                    assert(type(value) == "string","value must be string")
                    -- local tempData = MySQL.Sync.Fetch(
                    --     "player_config","*",
                    --       {
                    --         {Method = "AND" , Column = "SteamID" , Value = self.SteamID.Get() , Operator = "="},
                    --         {Method = "AND" , Column = "KeyName" , Value = key, Operator = "="}
                    --     }
                    -- )
                    local tempData = MySQL.Sync.Query("SELECT * FROM player_config WHERE SteamID=? AND KeyName=?",{
                        self.SteamID.Get(),
                        key
                    })
                    if tempData[1] then
                        -- MySQL.Sync.Update("player_config",
                        --     {
                        --         {Column = "SteamID", Value = self.SteamID.Get()},
                        --         {Column = "KeyName", Value = key},
                        --         {Column = "Value", Value = value}
                        --     },
                        --     {
                        --         {Method = "AND" , Column = "SteamID" , Value = self.SteamID.Get() , Operator = "="},
                        --         {Method = "AND" , Column = "KeyName" , Value = key, Operator = "="}
                        --     }
                        -- )
                        MySQL.Sync.Query("UPDATE player_config SET Value=? WHERE SteamID=? AND KeyName=?",{
                            value,
                            self.SteamID.Get(),
                            key
                        })
                    else
                        -- MySQL.Sync.Insert("player_config",
                        --     {
                        --         {Column = "SteamID", Value = self.SteamID.Get()},
                        --         {Column = "KeyName", Value = key},
                        --         {Column = "Value", Value = value}
                        --     }
                        -- )
                        MySQL.Sync.Query("INSERT INTO player_config (SteamID,KeyName,Value) VALUES (?,?,?)",{
                            self.SteamID.Get(),
                            key,
                            value
                        })
                    end
                end
            
                self.Config.Get = function(key)
                    -- return MySQL.Sync.Fetch(
                    --     "player_config",{"Value"},
                    --     {
                    --         {Method = "AND" , Column = "SteamID" , Value = self.SteamID.Get() , Operator = "="},
                    --         {Method = "AND" , Column = "KeyName" , Value = key, Operator = "="},
                    --     }
                    -- )[1].Value
                    return MySQL.Sync.Query("SELECT Value FROM player_config WHERE SteamID=? AND KeyName=?",{
                        self.SteamID.Get(),
                        key
                    })[1].Value
                end
            
                self.Config.Delete = function(key)
                    -- MySQL.Sync.Delete("player_config",
                    --     {
                    --         {Method = "AND" , Column = "SteamID" , Value = self.SteamID.Get() , Operator = "="},
                    --         {Method = "AND" , Column = "KeyName" , Value = key, Operator = "="},
                    --     }
                    -- )
                    MySQL.Sync.Query("DELETE FROM player_config WHERE SteamID=? AND KeyName=?",{
                        self.SteamID.Get(),
                        key
                    })
                end
                self.Inventory = {}
                ---get specific item in inventory
                ---@param itemName string specific item you want to get
                ---@return InventoryItem item item class with itemTable.Amount itemTable.Density itemTable.AttachData itemTable.ID
                self.Inventory.GetItem = function(itemName)
                    -- local value = MySql.Sync.Fetch("player_items","*",{
                    --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    --     {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
                    -- })
                    local value = MySql.Sync.Query("SELECT * FROM player_items WHERE SteamID=? AND ItemName=?",{
                        self.SteamID.Get(),
                        itemName
                    })
                    local itemTable = exports.wx_module_system:RequestModule("Item").GetItem(itemName)
                    itemTable.Amount = value[1].ItemAmount
                    itemTable.Density = value[1].ItemAmount
                    itemTable.ItemAmount = value[1].ItemAmount
                    itemTable.ItemAmount = value[1].ItemAmount
                    itemTable.AttachData = json.decode(value[1].ItemAttachData)
                    itemTable.ID = value[1].IID
                    return itemTable
                end
            
                ---get all item in inventory
                ---@return table<integer,InventoryItem> item table with item like {Inventory.GetItem(1),Inventory.GetItem(2),...}
                self.Inventory.GetItems = function()
                    -- local value = MySql.Sync.Fetch("player_items","*",{
                    --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    -- })
                    local value = MySql.Sync.Query("SELECT * FROM player_items WHERE SteamID=?",{
                        self.SteamID.Get()
                    })
                    local Table = {}
                    for k,v in pairs(value) do
                        local itemTable = exports.wx_module_system:RequestModule("Item").GetItem(v.ItemName)
                        itemTable.Amount = v.ItemAmount
                        itemTable.Density = v .ItemAmount
                        itemTable.AttachData = json.decode(v.ItemAttachData)
                        itemTable.ID = v .IID
                        table.insert(Table,itemTable)
                    end
                    return Table
                end
                ---get is item exist in inventory
                ---@param itemName string specific item you want to know if that exist
                ---@return boolean item item exist or not
                self.Inventory.IsItemExists = function(itemName)
                    -- local value = MySql.Sync.Fetch("player_items","*",{
                    --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    --     {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
                    -- })
                    local value = MySql.Sync.Query("SELECT * FROM player_items WHERE SteamID=? AND ItemName=?",{
                        self.SteamID.Get(),
                        itemName
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
                    -- return MySql.Sync.Fetch("player",{"MaxItemCanHold"},{
                    --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    -- })[1].MaxItemCanHold
                    return MySql.Sync.Query("SELECT MaxItemCanHold FROM player WHERE SteamID=?",{
                        self.SteamID.Get()
                    })[1].MaxItemCanHold
                end
            
                ---get max density can player hold
                ---@return number item max density can player hold
                self.Inventory.GetMaxDensityCanHold = function()
                    -- return MySql.Sync.Fetch("player",{"MaxDensityCanHold"},
                    --     {
                    --         {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    --     }
                    -- )[1].MaxDensityCanHold
                    return MySql.Sync.Query("SELECT MaxDensityCanHold FROM player WHERE SteamID=?",{
                        self.SteamID.Get()
                    })[1].MaxDensityCanHold
                end
            
                ---get total item count
                ---@return number item item count
                self.Inventory.GetTotalItemCount = function()
                    -- local value = MySql.Sync.Fetch("player_items","*",{
                    --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    -- })
                    local value = MySql.Sync.Query("SELECT * FROM player_items WHERE SteamID=?",{
                        self.SteamID.Get()
                    })
                    local count = 0
                    for _,v in pairs(value) do
                        count = count + v.ItemAmount
                    end
                    return count
                end
            
                ---get total density count
                ---@return number density total density
                self.Inventory.GetTotalDensity = function()
                    -- local value = MySql.Sync.Fetch("player_items","*",{
                    --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                    -- })
                    local value = MySql.Sync.Query("SELECT * FROM player_items WHERE SteamID=?",{
                        self.SteamID.Get()
                    })
                    local density = 0
                    for _,v in pairs(value) do
                        density = density + v.ItemAmount
                    end
                    return density
                end
                ---give item to player
                ---@param itemName string item name to give
                ---@param amount number amount to give
                ---@param isForce boolean is bypass the cheak
                ---@param attachData table attach data
                ---@return boolean isSuccess is item give success or not
                self.Inventory.GiveItem = function(itemName,amount,isForce,attachData)
                    if self.Inventory.IsItemExists(itemName) then
                        local iteminfo = exports.wx_module_system:RequestModule("Item").GetItem(itemName)
                        local before = self.Inventory.GetItem(itemName)
                        local max_density = self.Inventory.GetMaxDensityCanHold()
                        local max_item = self.Inventory.GetMaxItemCanHold()
                        if isForce then
                            -- MySql.Sync.Insert("player_items",
                            --     {
                            --         {Column = "SteamID" , Value = self.SteamID.Get()},
                            --         {Column = "ItemName" , Value = itemName},
                            --         {Column = "ItemAmount" , Value = amount},
                            --         {Column = "ItemDensity" , Value = iteminfo.ItemDensity * amount},
                            --         {Column = "ItemAttachData" , Value = json.encode(attachData)},
                            --     }
                            -- )
                            MySql.Sync.Query("INSERT INTO player_items (SteamID,ItemName,ItemAmount,ItemDensity,ItemAttachData) VALUES (?,?,?,?,?)",{
                                self.SteamID.Get(),
                                itemName,
                                amount,
                                iteminfo.ItemDensity * amount,
                                json.encode(attachData)
                            })
                            return true
                        else
                            if self.Inventory.GetTotalItemCount() + amount <= max_item then
                                if self.Inventory.GetTotalDensity() + (iteminfo.ItemDensity*amount) <= max_density then
                                    -- MySql.Sync.Update("player_items",
                                    --     {
                                    --         {Column = "ItemAmount", Value = before.Amount + amount},
                                    --         {Column = "ItemAttachData", Value = json.encode(attachData)},
                                    --         {Column = "ItemDensity", Value = ((before.Amount + amount) * iteminfo.ItemDensity)}
                                    --     },
                                    --     {
                                    --         {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                                    --         {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
                                    --     }
                                    -- )
                                    MySql.Sync.Query("UPDATE player_items SET ItemAmount=?,ItemAttachData=?,ItemDensity=? WHERE SteamID=? AND ItemName=?",{
                                        before.Amount + amount,
                                        json.encode(attachData),
                                        ((before.Amount + amount) * iteminfo.ItemDensity),
                                        self.SteamID.Get(),
                                        itemName
                                    })
                                    return true
                                else
                                    return false
                                end
                            else
                                return false
                            end
                        end
                    else
                        local iteminfo = exports.wx_module_system:RequestModule("Item").GetItem(itemName)
                        local max_density = self.Inventory.GetMaxDensityCanHold()
                        local max_item = self.Inventory.GetMaxItemCanHold()
                        if self.Inventory.GetTotalItemCount() + amount <= max_item then
                            if self.Inventory.GetTotalDensity() + (iteminfo.ItemDensity*amount) <= max_density then
                                -- MySql.Sync.Insert("player_items",
                                --     {
                                --         {Column = "SteamID" , Value = self.SteamID.Get()},
                                --         {Column = "ItemName" , Value = itemName},
                                --         {Column = "ItemAmount" , Value = amount},
                                --         {Column = "ItemDensity" , Value = iteminfo.ItemDensity * amount},
                                --         {Column = "ItemAttachData" , Value = json.encode(attachData)},
                                --     }
                                -- )
                                MySql.Sync.Query("INSERT INTO player_items (SteamID,ItemName,ItemAmount,ItemDensity,ItemAttachData) VALUES (?,?,?,?,?)",{
                                    self.SteamID.Get(),
                                    itemName,
                                    amount,
                                    iteminfo.ItemDensity * amount,
                                    json.encode(attachData)
                                })
                                return true
                            else
                                return false
                            end
                        end
                    end
                end
                
                ---remove item from inventory
                ---@param itemName string item to remove
                ---@param amount number number of items to remove
                ---@return boolean isSuccess is item remove success or not
                self.Inventory.RemoveItem = function(itemName,amount)
                    if self.Inventory.IsItemExists(itemName) then
                        local before = self.Inventory.GetItem(itemName)
                        if before.Amount - amount < 0 then
                            return false
                        elseif before.Amount - amount == 0 then
                            -- MySql.Sync.Delete("player_items",
                            --     {
                            --         {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                            --         {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
                            --     }
                            -- )
                            MySql.Sync.Query("DELETE FROM player_items WHERE SteamID=? AND ItemName=?",{
                                self.SteamID.Get(),
                                itemName
                            })
                            return true
                        elseif before.Amount - amount > 0 then
                            -- MySql.Sync.Update("player_items",
                            --     {
                            --         {Column = "ItemAmount", Value = before.Amount - amount},
                            --         {Column = "ItemDensity", Value = ((before.Amount - amount) * exports.wx_module_system:RequestModule("Item").GetItem(itemName).ItemDensity)},
                            --     },
                            --     {
                            --         {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()},
                            --         {Method = "AND",Operator = "=",Column = "ItemName",Value = itemName}
                            --     }
                            -- )
                            MySql.Sync.Query("UPDATE player_items SET ItemAmount=?,ItemDensity=? WHERE SteamID=? AND ItemName=?",{
                                before.Amount - amount,
                                ((before.Amount - amount) * exports.wx_module_system:RequestModule("Item").GetItem(itemName).ItemDensity),
                                self.SteamID.Get(),
                                itemName
                            })
                            return true
                        else
                            return false
                        end
                    else
                        return false
                    end
                end
            
                ---use item
                ---@param itemName string item to use
                ---@param amount number amount to use
                ---@return boolean isSuccess is item use success or not
                self.Inventory.UseItem = function(itemName,amount)
                    local info  = self.Inventory.GetItem(itemName)
                    local item = exports.wx_module_system:RequestModule("Item").GetItem(itemName)
                    if item.ItemMaxUseAmount >= amount then
                        local r = self.Inventory.RemoveItem(itemName,amount)
                        if r then
                            Citizen.CreateThread(function()                
                                item.UseFunction(self.PlayerID.Get(),amount,info.AttachData,
                                    function()
                                        self.Inventory.GiveItem(itemName,amount,false,info.AttachData)
                                        return false
                                    end
                                )
                            end)
                            return true
                        else
                            return false
                        end
                    else
                        return false
                    end
                end
            
                self.Inventory.DropItem = function(itemName,amount)
                    local item = exports.wx_module_system:RequestModule("Item").GetItem(itemName)
                    math.randomseed(os.time()*2/os.time()+(os.time())/math.random())
                    local ticket = tostring(math.random(0,10000000000000000))
                    drop_ticket[ticket] = 
                    {
                        ItemName = itemName,
                        Amount = amount,
                        AttachData = self.Inventory.GetItem(itemName).AttachData,
                    }
                    local coords = GetEntityCoords(GetPlayerPed(self.PlayerID.Get()))
                    self.Inventory.RemoveItem(itemName,amount)
                    TriggerClientEvent("wx_player_inventory:drop",-1,item.ItemShowName,amount,item.ItemModel,item.IsItemPhysicalAfterDrop,coords,ticket)
                end

                self.Notification = {}
                ---show notification
                ---@param message string|integer|number message to show
                self.Notification.ShowNotification = function(message)
                    TriggerClientEvent("wx_player_notify:ShowNotification",self.PlayerID.Get(),message)
                end
                ---show message box with image
                ---@param iconplayerid string|integer player id
                ---@param sender_name string name of sender
                ---@param title string title of message box
                ---@param message string content of message box
                ---@param iconType integer 1=Chat Box,2=Email,3=Add Friend Request,7=Right Jumping Arrow,8=RP Icon,9=$ Icon
                ---@param hudColor integer https://docs.fivem.net/docs/game-references/hud-colors/
                self.Notification.ShowAdvancedNotification = function(iconplayerid,sender_name,title,message,iconType,hudColor)
                    TriggerClientEvent("wx_player_notify:ShowAdvancedNotification",self.PlayerID.Get(),iconplayerid,sender_name,title,message,iconType,hudColor)
                end
                ---show help message
                ---@param message string|integer|number message to show
                ---@param beep boolean beep or not
                self.Notification.ShowHelpNotification = function (message, beep,duration)
                    TriggerClientEvent('wx_player_notify:ShowHelpNotification',self.PlayerID.Get(),message,beep,duration)
                end
                self.Notification.ShowFloatingHelpNotification = function (message,coords,duration)
                    TriggerClientEvent('wx_player_notify:ShowFloatingHelpNotification',self.PlayerID.Get(),message,coords,duration)
                end
                ---show freemode message
                ---@param title string|integer|number title of message
                ---@param message string|integer|number message to show
                ---@param duration integer|number time to show in ms
                self.Notification.ShowFreemodeMessage = function (title, message,duration)
                    TriggerClientEvent('wx_player_notify:ShowFreemodeMessage',self.PlayerID.Get(),title,message,duration)
                end
                ---show news bar on bottom
                ---@param title string|integer|number title of news
                ---@param message string|integer|number message to show
                ---@param bottomtext string|integer|number bottom text
                ---@param duration integer|number time to show in ms
                self.Notification.ShowBreakingNews = function (title, message,bottomtext,duration)
                    TriggerClientEvent('wx_player_notify:ShowBreakingNews',self.PlayerID.Get(),title,message,bottomtext,duration)
                end
                ---show pop up message such as GTA OL ban message
                ---@param title string|integer|number title of message
                ---@param message string|integer|number message to show
                ---@param bottomtext string|integer|number bottom text
                ---@param duration integer|number time to show in ms
                self.Notification.ShowPopupWarning = function (title, message,bottomtext,duration)
                    TriggerClientEvent('wx_player_notify:ShowPopupWarning',self.PlayerID.Get(),title,message,bottomtext,duration)
                end
                
                self.Physiology = {
                    --satiety = 飽食度
                    Satiety = {
                        Get = function()
                            -- return MySql.Sync.Fetch("player",{"Satiety"},{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })[1].Satiety
                            return MySql.Sync.Query("SELECT Satiety FROM player WHERE SteamID=?",{
                                self.SteamID.Get()
                            })[1].Satiety
                        end,
                        Set = function(value)
                            -- MySql.Sync.Update("player",{
                            --     {Column = "Satiety" , Value = value}
                            -- },{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })
                            MySql.Sync.Query("UPDATE player SET Satiety=? WHERE SteamID=?",{
                                value,
                                self.SteamID.Get()
                            })
                            TriggerClientEvent("wx_player_physiology_system:UpdateSatiety",self.PlayerID.Get(),value)
                            Console.Log("Physiology Set Player:"..self.SteamID.Get().." Satiety to "..value,true)
                        end,
                        Add = function(value)
                            local finalValue = self.Physiology.Satiety.Get() + value
                            Console.Log("Physiology Add Player:"..self.SteamID.Get().." "..value.." Satiety from"..self.Physiology.Satiety.Get().." to "..finalValue,true)
                            self.Physiology.Satiety.Set(finalValue)
                            return finalValue
                        end,
                        Remove = function(value)
                            local finalValue = self.Physiology.Satiety.Get() - value
                            Console.Log("Physiology Remove Player:"..self.SteamID.Get().." "..value.." Satiety from"..self.Physiology.Satiety.Get().." to "..finalValue,true)
                            self.Physiology.Satiety.Set(finalValue)
                            return finalValue
                        end,
                        Increase = function(value) return self.Physiology.Satiety.Add(value) end,
                        Decrease = function(value) return self.Physiology.Satiety.Remove(value) end,
                    },
                    --thirst = 乾渴度
                    Thirst = {
                        Get = function()
                            -- return MySql.Sync.Fetch("player",{"Thirst"},{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })[1].Thirst
                            return MySql.Sync.Query("SELECT Thirst FROM player WHERE SteamID=?",{
                                self.SteamID.Get()
                            })[1].Thirst
                        end,
                        Set = function(value)
                            -- MySql.Sync.Update("player",{
                            --     {Column = "Thirst" , Value = value}
                            -- },{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })
                            MySql.Sync.Query("UPDATE player SET Thirst=? WHERE SteamID=?",{
                                value,
                                self.SteamID.Get()
                            })
                            TriggerClientEvent("wx_player_physiology_system:UpdateThirst",self.PlayerID.Get(),value)
                            Console.Log("Physiology Set Player:"..self.SteamID.Get().." Thirst to "..value,true)
                        end,
                        Add = function(value)
                            local finalValue = self.Physiology.Thirst.Get() + value
                            Console.Log("Physiology Add Player:"..self.SteamID.Get().." "..value.." Thirst from"..self.Physiology.Thirst.Get().." to "..finalValue,true)
                            self.Physiology.Thirst.Set(finalValue)
                            return finalValue
                        end,
                        Remove = function(value)
                            local finalValue = self.Physiology.Thirst.Get() - value
                            Console.Log("Physiology Remove Player:"..self.SteamID.Get().." "..value.." Thirst from"..self.Physiology.Thirst.Get().." to "..finalValue,true)
                            self.Physiology.Thirst.Set(finalValue)
                            return finalValue
                        end,
                        Increase = function(value) return self.Physiology.Thirst.Add(value) end,
                        Decrease = function(value) return self.Physiology.Thirst.Remove(value) end,
                    },
                    --tiredness = 疲倦感
                    Tiredness = {
                        Get = function()
                            -- return MySql.Sync.Fetch("player",{"Tiredness"},{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })[1].Tiredness
                            return MySql.Sync.Query("SELECT Tiredness FROM player WHERE SteamID=?",{
                                self.SteamID.Get()
                            })[1].Tiredness
                        end,
                        Set = function(value)
                            -- MySql.Sync.Update("player",{
                            --     {Column = "Tiredness" , Value = value}
                            -- },{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })
                            MySql.Sync.Query("UPDATE player SET Tiredness=? WHERE SteamID=?",{
                                value,
                                self.SteamID.Get()
                            })
                            TriggerClientEvent("wx_player_physiology_system:UpdateTiredness",self.PlayerID.Get(),value)
                            Console.Log("Physiology Set Player:"..self.SteamID.Get().." Tiredness to "..value,true)
                        end,
                        Add = function(value)
                            local finalValue = self.Physiology.Tiredness.Get() + value
                            Console.Log("Physiology Add Player:"..self.SteamID.Get().." "..value.." Tiredness from"..self.Physiology.Tiredness.Get().." to "..finalValue,true)
                            self.Physiology.Tiredness.Set(finalValue)
                            return finalValue
                        end,
                        Remove = function(value)
                            local finalValue = self.Physiology.Tiredness.Get() - value
                            Console.Log("Physiology Remove Player:"..self.SteamID.Get().." "..value.." Tiredness from"..self.Physiology.Tiredness.Get().." to "..finalValue,true)
                            self.Physiology.Tiredness.Set(finalValue)
                            return finalValue
                        end,
                        Increase = function(value) return self.Physiology.Tiredness.Add(value) end,
                        Decrease = function(value) return self.Physiology.Tiredness.Remove(value) end,
                    },
                    --urine = 尿
                    Urine = {
                        Get = function()
                            -- return MySql.Sync.Fetch("player",{"Urine"},{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })[1].Urine
                            return MySql.Sync.Query("SELECT Urine FROM player WHERE SteamID=?",{
                                self.SteamID.Get()
                            })[1].Urine
                        end,
                        Set = function(value)
                            -- MySql.Sync.Update("player",{
                            --     {Column = "Urine" , Value = value}
                            -- },{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })
                            MySql.Sync.Query("UPDATE player SET Urine=? WHERE SteamID=?",{
                                value,
                                self.SteamID.Get()
                            })
                            TriggerClientEvent("wx_player_physiology_system:UpdateUrine",self.PlayerID.Get(),value)
                            Console.Log("Physiology Set Player:"..self.SteamID.Get().." Urine to "..value,true)
                        end,
                        Add = function(value)
                            local finalValue = self.Physiology.Urine.Get() + value
                            Console.Log("Physiology Add Player:"..self.SteamID.Get().." "..value.." Urine from"..self.Physiology.Urine.Get().." to "..finalValue,true)
                            self.Physiology.Urine.Set(finalValue)
                            return finalValue
                        end,
                        Remove = function(value)
                            local finalValue = self.Physiology.Urine.Get() - value
                            Console.Log("Physiology Remove Player:"..self.SteamID.Get().." "..value.." Urine from"..self.Physiology.Urine.Get().." to "..finalValue,true)
                            self.Physiology.Urine.Set(finalValue)
                            return finalValue
                        end,
                        Increase = function(value) return self.Physiology.Urine.Add(value) end,
                        Decrease = function(value) return self.Physiology.Urine.Remove(value) end,
                    },
                    --shit = 你
                    Shit = {
                        Get = function()
                            -- return MySql.Sync.Fetch("player",{"Shit"},{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })[1].Shit
                            return MySql.Sync.Query("SELECT Shit FROM player WHERE SteamID=?",{
                                self.SteamID.Get()
                            })[1].Shit
                        end,
                        Set = function(value)
                            -- MySql.Sync.Update("player",{
                            --     {Column = "Shit" , Value = value}
                            -- },{
                            --     {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                            -- })
                            MySql.Sync.Query("UPDATE player SET Shit=? WHERE SteamID=?",{
                                value,
                                self.SteamID.Get()
                            })
                            TriggerClientEvent("wx_player_physiology_system:UpdateShit",self.PlayerID.Get(),value)
                            Console.Log("Physiology Set Player:"..self.SteamID.Get().." Shit to "..value,true)
                        end,
                        Add = function(value)
                            local finalValue = self.Physiology.Shit.Get() + value
                            Console.Log("Physiology Add Player:"..self.SteamID.Get().." "..value.." Shit from"..self.Physiology.Shit.Get().." to "..finalValue,true)
                            self.Physiology.Shit.Set(finalValue)
                            return finalValue
                        end,
                        Remove = function(value)
                            local finalValue = self.Physiology.Shit.Get() - value
                            Console.Log("Physiology Remove Player:"..self.SteamID.Get().." "..value.." Shit from"..self.Physiology.Shit.Get().." to "..finalValue,true)
                            self.Physiology.Shit.Set(finalValue)
                            return finalValue
                        end,
                        Increase = function(value) return self.Physiology.Shit.Add(value) end,
                        Decrease = function(value) return self.Physiology.Shit.Remove(value) end,
                    }
                }
                
                self.LastPosition = {}
                ---@class vector3
                
                ---get player last saved position
                ---@return vector3 | boolean state if valid position return vec3 else return false
                self.LastPosition.Get = function()
                    local result = MySql.Sync.Query("SELECT LastPosition FROM player WHERE SteamID = ?",{
                        self.SteamID.Get()
                    })
                    if result and result[1] then
                        result = json.decode(result[1].LastPosition)
                        return vec3(result.x,result.y,result.z)
                    end
                    return false
                end
             
                ---set last saved position
                ---@param vector3 vector3 | table struct of {x,y,z}
                ---@param ... number
                self.LastPosition.Set = function(vector3,...)
                    if type(vector3) == "table" or type(vector3) == "vector3" then
                        MySql.Sync.Query("UPDATE player SET LastPosition = ? WHERE SteamID = ?",{
                            json.encode(vector3),
                            self.SteamID.Get()
                        })
                    elseif #{...} == 2 then
                        local tempParms = {...}
                        local tempVec3 = vec3(vector3,tempParms[2],tempParms[3])
                        MySql.Sync.Query("UPDATE player SET LastPosition = ? WHERE SteamID = ?",{
                            json.encode(tempVec3),
                            self.SteamID.Get()
                        })
                    end
                end

                self.Coords = {}
                ---get player Coords
                ---@return vector3 position coords
                self.Coords.Get = function()
                    return GetEntityCoords(GetPlayerPed(self.source))
                end
                ---set player Coords
                ---@param x number|integer coords x
                ---@param y number|integer coords y
                ---@param z number|integer coords z
                self.Coords.Set = function(x,y,z)
                    x,y,z = x+0.0,y+0.0,z+0.0
                    SetEntityCoords(GetPlayerPed(self.source),x,y,z,true,true,true,false)
                end
                    
                self.Rotation = {}
                ---get player Rotation
                ---@return vector3 rotation
                self.Rotation.Get = function()
                    return GetEntityRotation(GetPlayerPed(self.source))
                end
                ---set player Rotation
                ---@param pitch number|integer rotation pitch
                ---@param roll number|integer rotation roll
                ---@param yaw number|integer rotation yaw
                self.Rotation.Set = function(pitch ,roll ,yaw )
                    pitch ,roll ,yaw = pitch+0.0,roll+0.0,yaw+0.0
                    SetEntityRotation(GetPlayerPed(self.source),pitch ,roll ,yaw ,1 ,true)
                end

                return self
            end,
            GetAllPlayers = function()
                local players = GetPlayers()
                local result = {}
                for _, v in pairs(players) do
                    table.insert(result, exports.wx_module_system:RequestModule("Player").GetPlayer(v))
                end
                return result
            end,
            AddModule = function(ModuleName, Module)
                playerobj[ModuleName] = Module
                table.insert(modulelist,ModuleName)
            end,

        }
    elseif moduleName == "Console" then
        return {
            Log = function(str,logToConsole) end,
            Warn = function(str,logToConsole) end,
            Error = function(str,logToConsole) end,
        }
    elseif moduleName == "Utils" then
        return {
            GenerateRandomFloat = function(min,max)
                return Callback.TriggerServerCallback("wx_utils:generateRandomFloat",min,max)
            end,
            GenerateRandomInt = function(min,max)
                return Callback.TriggerServerCallback("wx_utils:generateRandomInt",min,max)
            end,
            GenerateRandomString = function(length)
                return Callback.TriggerServerCallback("wx_utils:generateRandomString",length)
            end,
            GenerateRandomBoolean = function()
                return Callback.TriggerServerCallback("wx_utils:generateRandomBoolean")
            end,
            GetEntityPointingAt = function(entity,length)
                return (GetOffsetFromEntityInWorldCoords(entity,0.0,length or 10.0,0.0)-GetEntityCoords(entity))
            end,
            Round = function(exact, quantum) --令数字取整
                return tonumber(tostring(exact):sub(1, tostring(exact):find('.') + quantum +1))
            end,
            GetEntityHeading = function(entity)
                local p = GetOffsetFromEntityInWorldCoords(entity,0.0,1000.0,0.0)
                p = GetHeadingFromVector_2d(
	        	    GetEntityCoords(entity).x - p.x --[[ number ]], 
	        	    GetEntityCoords(entity).y - p.y --[[ number ]]
	            )
                return p
            end,
            GetVehicleProperties = function(vehicle)
            	if DoesEntityExist(vehicle) then
            		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            		local extras = {}
                
            		for extraId=0, 12 do
            			if DoesExtraExist(vehicle, extraId) then
            				local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
            				extras[tostring(extraId)] = state
            			end
            		end
                
            		return {
            			model             = GetEntityModel(vehicle),
                    
            			plate             = GetVehicleNumberPlateText(vehicle),
            			plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),
                    
            			bodyHealth        = GetVehicleBodyHealth(vehicle),
            			engineHealth      = GetVehicleEngineHealth(vehicle),
            			tankHealth        = GetVehiclePetrolTankHealth(vehicle),
                    
            			fuelLevel         = GetVehicleFuelLevel(vehicle),
            			dirtLevel         = GetVehicleDirtLevel(vehicle),
            			color1            = colorPrimary,
            			color2            = colorSecondary,
                    
            			pearlescentColor  = pearlescentColor,
            			wheelColor        = wheelColor,
                    
            			wheels            = GetVehicleWheelType(vehicle),
            			windowTint        = GetVehicleWindowTint(vehicle),
            			xenonColor        = GetVehicleXenonLightsColor(vehicle),
                    
            			neonEnabled       = {
            				IsVehicleNeonLightEnabled(vehicle, 0),
            				IsVehicleNeonLightEnabled(vehicle, 1),
            				IsVehicleNeonLightEnabled(vehicle, 2),
            				IsVehicleNeonLightEnabled(vehicle, 3)
            			},
                    
            			neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
            			extras            = extras,
            			tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),
                    
            			modSpoilers       = GetVehicleMod(vehicle, 0),
            			modFrontBumper    = GetVehicleMod(vehicle, 1),
            			modRearBumper     = GetVehicleMod(vehicle, 2),
            			modSideSkirt      = GetVehicleMod(vehicle, 3),
            			modExhaust        = GetVehicleMod(vehicle, 4),
            			modFrame          = GetVehicleMod(vehicle, 5),
            			modGrille         = GetVehicleMod(vehicle, 6),
            			modHood           = GetVehicleMod(vehicle, 7),
            			modFender         = GetVehicleMod(vehicle, 8),
            			modRightFender    = GetVehicleMod(vehicle, 9),
            			modRoof           = GetVehicleMod(vehicle, 10),
                    
            			modEngine         = GetVehicleMod(vehicle, 11),
            			modBrakes         = GetVehicleMod(vehicle, 12),
            			modTransmission   = GetVehicleMod(vehicle, 13),
            			modHorns          = GetVehicleMod(vehicle, 14),
            			modSuspension     = GetVehicleMod(vehicle, 15),
            			modArmor          = GetVehicleMod(vehicle, 16),
                    
            			modTurbo          = IsToggleModOn(vehicle, 18),
            			modSmokeEnabled   = IsToggleModOn(vehicle, 20),
            			modXenon          = IsToggleModOn(vehicle, 22),
                    
            			modFrontWheels    = GetVehicleMod(vehicle, 23),
            			modBackWheels     = GetVehicleMod(vehicle, 24),
                    
            			modPlateHolder    = GetVehicleMod(vehicle, 25),
            			modVanityPlate    = GetVehicleMod(vehicle, 26),
            			modTrimA          = GetVehicleMod(vehicle, 27),
            			modOrnaments      = GetVehicleMod(vehicle, 28),
            			modDashboard      = GetVehicleMod(vehicle, 29),
            			modDial           = GetVehicleMod(vehicle, 30),
            			modDoorSpeaker    = GetVehicleMod(vehicle, 31),
            			modSeats          = GetVehicleMod(vehicle, 32),
            			modSteeringWheel  = GetVehicleMod(vehicle, 33),
            			modShifterLeavers = GetVehicleMod(vehicle, 34),
            			modAPlate         = GetVehicleMod(vehicle, 35),
            			modSpeakers       = GetVehicleMod(vehicle, 36),
            			modTrunk          = GetVehicleMod(vehicle, 37),
            			modHydrolic       = GetVehicleMod(vehicle, 38),
            			modEngineBlock    = GetVehicleMod(vehicle, 39),
            			modAirFilter      = GetVehicleMod(vehicle, 40),
            			modStruts         = GetVehicleMod(vehicle, 41),
            			modArchCover      = GetVehicleMod(vehicle, 42),
            			modAerials        = GetVehicleMod(vehicle, 43),
            			modTrimB          = GetVehicleMod(vehicle, 44),
            			modTank           = GetVehicleMod(vehicle, 45),
            			modWindows        = GetVehicleMod(vehicle, 46),
            			modLivery         = GetVehicleLivery(vehicle)
            		}
            	else
            		return
            	end
            end,
            SetVehicleProperties = function(vehicle, props)
            	if DoesEntityExist(vehicle) then
            		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            		SetVehicleModKit(vehicle, 0)
                
            		if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
            		if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
            		if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
            		if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
            		if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
            		if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
            		if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
            		if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
            		if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
            		if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
            		if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
            		if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
            		if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end
                
            		if props.neonEnabled then
            			SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
            			SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
            			SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
            			SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
            		end
                
            		if props.extras then
            			for extraId,enabled in pairs(props.extras) do
            				if enabled then
            					SetVehicleExtra(vehicle, tonumber(extraId), 0)
            				else
            					SetVehicleExtra(vehicle, tonumber(extraId), 1)
            				end
            			end
            		end
                
            		if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
            		if props.xenonColor then SetVehicleXenonLightsColor(vehicle, props.xenonColor) end
            		if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
            		if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
            		if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
            		if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
            		if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
            		if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
            		if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
            		if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
            		if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
            		if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
            		if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
            		if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
            		if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
            		if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
            		if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
            		if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
            		if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
            		if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
            		if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
            		if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) end
            		if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) end
            		if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
            		if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
            		if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
            		if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
            		if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
            		if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
            		if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
            		if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
            		if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
            		if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
            		if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
            		if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
            		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
            		if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
            		if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
            		if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
            		if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
            		if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
            		if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
            		if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
            		if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
            		if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
            		if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
            		if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end
                
            		if props.modLivery then
            			SetVehicleMod(vehicle, 48, props.modLivery, false)
            			SetVehicleLivery(vehicle, props.modLivery)
            		end
            	end
            end
        }
    elseif moduleName == "PhoneApp" then
        --- Register App Parameters
        ---@class App
        AppParameters = {
            packageName          = "com.example.phoneapp",
            displayName          = "phoneapp",
            icon                 = "phoneapp.png",
            overwrite            = false,
            url                  = "nui://example/index.html",
            version              = "1.0.0",
            author               = "example",
            authorUrl            = "https://example.com",
            description          = "phoneapp description",
            isSystemApp          = false,
            isUploadToAppStore   = true,
            isUploadToGooglePlay = true,
            isPaySoftware        = false,
            price                = 0.0,
            size                 = 0,
            onAppOpen            = function() end,
            onAppClose           = function() end,
            onAppInstall         = function() end,
            onAppUninstall       = function() end,
        }
        return {
            ---get app by package name
            ---@param packageName string package name
            ---@return App
            GetAppByPackageName = function(packageName)
            end,
            ---get app by index
            ---@param index number index
            ---@return App
            ---@return nil error when not found
            GetAppByIndex = function(index)
            end,
            ---get app index list
            ---@return table<integer, string> app app index list
            GetAppPackageList = function()
            end,
            ---get app package table
            ---@return table<string,App>
            GetAppPackageTable = function()
            end,
        }
    elseif moduleName == "Item" then
        ---@class Item
        ---@table Item
        ItemClass = {
            ItemName                = "",
            ItemShowName            = "",
            ItemType                = "",
            ItemDescription         = "",
            ItemDensity             = 0.0,
            ItemModel               = "",
            ItemMaxDensity          = 0.0,
            ItemMaxUseAmount        = 0,              --[[物品单次最大使用数]]
            ItemMaxThrowAmount      = 0,              --[[物品单次最大丢弃数]]
            ItemMaxTransferAmount   = 0,              --[[物品单次最大转移数]]
            ItemImage               = "",             --[[支持base64  基于html src ]]
            ItemMaxAmount           = 0,
            ItemMaxStack            = 0,
            CanItemDrop             = false,
            CanItemPickup           = false,
            CanItemUse              = false,
            CanItemTransfer         = false,
            CanItemCombine          = false,
            IsItemPhysicalAfterDrop = false,
            UseFunction             = function() end,
            DropFunction            = function() end,
            PickupFunction          = function() end,
            StackFunction           = function() end,
            TransferFunction        = function() end,
            IsEnableAntiCheat       = false,
        }
        return {
            ---get item
            ---@param itemName string name of the item
            ---@return Item
            GetItem = function(itemName)
            end,
        }
    elseif moduleName == "Phone" then
        ---get phone class
        ---@param PID number | string pid of phone
        ---@return table Phone phone class
        GetPhone = function(PID)
            assert(type(PID) == "number" or type(PID) == "string","PID must be a number or string")
            if type(PID) == "string" then
                local PPID = PID
                PID = tonumber(PID)
                assert(type(PID) == "number","fail to cast PID to number, cast value:" .. PPID)
            end
            local self = {}
            self.__index = self

            self.Pid = {
                Get = function()
                    return PID
                end,
            }

            self.PhonePassword = {
                Get = function()
                    return MySql.Sync.Query("SELECT PhonePassword FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhonePassword
                end,
                Set = function(value)
                    assert(type(value) == "string" or type(value) == "number","PhonePassword must be a string or number")
                    value = tostring(value)
                    MySql.Sync.Query("UPDATE player_phone SET PhonePassword = ? WHERE PID = ?",{
                        value,
                        self.Pid.Get()
                    })
                end,
            }

            self.PhoneModule = {
                Get = function()
                    return MySql.Sync.Query("SELECT PhoneModule FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhoneModule
                end,
                Set = function(value)
                    assert(type(value) == "string","PhoneModule must be a string")
                    MySql.Sync.Query("UPDATE player_phone SET PhoneModule = ? WHERE PID = ?",{
                        value,
                        self.Pid.Get()
                    })
                end,
            }

            self.PhoneSetting = {
                Get = function()
                    return json.decode(MySql.Sync.Query("SELECT PhoneSetting FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhoneSetting)
                end,
                Set = function(value)
                    assert(type(value) == "table","PhoneSetting must be a table")
                    MySql.Sync.Query("UPDATE player_phone SET PhoneSetting = ? WHERE PID = ?",{
                        json.encode(value),
                        self.Pid.Get()
                    })
                end,
            }

            self.PhoneApps = {
                Get = function()
                    return json.decode(MySql.Sync.Query("SELECT PhoneApps FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhoneApps)
                end,
                Set = function(value)
                    assert(type(value) == "table","PhoneApps must be a table")
                    MySql.Sync.Query("UPDATE player_phone SET PhoneApps = ? WHERE PID = ?",{
                        json.encode(value),
                        self.Pid.Get()
                    })
                end,
                Add = function(appPackageName)
                    assert(type(appPackageName) == "table", "value must be a table")
                    local app = exports.wx_module_system:RequestModule("PhoneApp").GetAppByPackageName("value")
                    if self.PhoneCurrentCapacity.Get() + app.size > self.PhoneMaxCapacity.Get() then
                        return nil
                    end
                    if app then
                        local prePhoneApps = self.PhoneApps.Get()
                        prePhoneApps[#prePhoneApps+1] = {
                            packageName          = app.packageName,
                            displayName          = app.displayName,
                            icon                 = app.icon,
                            overwrite            = app.overwrite,
                            url                  = app.url,
                            version              = app.version,
                            author               = app.author,
                            authorUrl            = app.authorUrl,
                            description          = app.description,
                            isSystemApp          = app.isSystemApp,
                            isUploadToAppStore   = app.isUploadToAppStore,
                            isUploadToGooglePlay = app.isUploadToGooglePlay,
                            isPaySoftware        = app.isPaySoftware,
                            price                = app.price,
                            size                 = app.size,
                        }
                        self.PhoneApps.Set(prePhoneApps)
                        MySql.Sync.Query("UPDATE player_phone SET PhoneCurrentCapacity = ? WHERE PID = ?", {
                            self.PhoneCurrentCapacity.Get() + app.size,
                            self.Pid.Get()
                        })
                    end
                    return nil
                end,
                Install = function(appPackageName) self.PhoneApps.Add(appPackageName) end,
                Uninstall = function(appPackageName)
                    local prePhoneApps = self.PhoneApps.Get()
                    for i,v in ipairs(prePhoneApps) do
                        if v.packageName == appPackageName then
                            table.remove(prePhoneApps,i)
                            break
                        end
                    end
                    self.PhoneApps.Set(prePhoneApps)
                end,
                Remove = function(appPackageName) self.PhoneApps.Uninstall(appPackageName) end,
            }

            self.PhoneRegisterDate = {
                Get = function()
                    return MySql.Sync.Query("SELECT PhoneRegisterDate FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhoneRegisterDate
                end,
                Set = function(value)
                    assert(type(value) == "number","PhoneRegisterDate must be a number")
                    MySql.Sync.Query("UPDATE player_phone SET PhoneRegisterDate = ? WHERE PID = ?",{
                        value,
                        self.Pid.Get()
                    })
                end,
            }

            self.PhoneMaxCapacity = {
                Get = function()
                    return MySql.Sync.Query("SELECT PhoneMaxCapacity FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhoneMaxCapacity
                end,
                Set = function(value)
                    assert(type(value) == "number","PhoneMaxCapacity must be a number")
                    MySql.Sync.Query("UPDATE player_phone SET PhoneMaxCapacity = ? WHERE PID = ?",{
                        value,
                        self.Pid.Get()
                    })
                end,
            }

            self.PhoneCurrentCapacity = {
                Get = function()
                    return MySql.Sync.Query("SELECT PhoneCurrentCapacity FROM player_phone WHERE PID = ?",{
                        self.Pid.Get()
                    })[1].PhoneCurrentCapacity
                end,
                Set = function(value)
                    assert(type(value) == "number","PhoneCurrentCapacity must be a number")
                    MySql.Sync.Query("UPDATE player_phone SET PhoneCurrentCapacity = ? WHERE PID = ?",{
                        value,
                        self.Pid.Get()
                    })
                end,
            }
        end
    end
end

MySql = {}
MySql.Sync = {}
MySql.Sync.Query = function(query, parameters) return {} end


json = {}
json.encode = function(table) return "" end
json.decode = function(str) return {} end

vec3 = function(x,y,z) return {} end