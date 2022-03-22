local MySQL = exports.wx_module_system:RequestModule("MySql")
TriggerEvent("RegisterPlayerModule","Config",function(self) --self 是隐式参数 self = Player.GetPlayer()
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

    return self
end)