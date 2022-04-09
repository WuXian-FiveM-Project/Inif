exports = {}
exports.wx_module_system  = {}

function exports.wx_module_system:RequestModule (moduleName)
    if moduleName == "Callback" then
        return
        {
            TriggerServerCallback = function (eventName,...)
                return ...
            end,
            TriggerCientCallback = function (eventName,playerID,...)
                return ...
            end,
            RegisterServerCallback = function (eventName,callback)
            end,
            RegisterClientCallback = function (eventName,callback)
            end,
        }
    elseif moduleName == "Player" then
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
                ---@return table item item class with itemTable.Amount itemTable.Density itemTable.AttachData itemTable.ID
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
                ---@return table item table with item like {Inventory.GetItem(1),Inventory.GetItem(2),...}
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
    end
end

MySql = {}
MySql.Sync = {}
MySql.Sync.Query = function(query, parameters) return {} end



json = {}
json.encode = function(table) return "" end
json.decode = function(str) return {} end

vec3 = function(x,y,z) return {} end