MySql = exports.wx_module_system:RequestModule("MySql")
Console = exports.wx_module_system:RequestModule("Console")
Player = exports.wx_module_system:RequestModule("Player")
Callback = exports.wx_module_system:RequestModule("Callback")

TriggerEvent("RegisterPlayerModule","Physiology",function(self) --self 是隐式参数 self = Player.GetPlayer(
    self.Physiology = {
        --satiety = 飽食度
        Satiety = {
            Get = function()
                return MySql.Sync.Fetch("player",{"Satiety"},{
                    {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                })[1].Satiety
            end,
            Set = function(value)
                MySql.Sync.Update("player",{
                    {Column = "Satiety" , Value = value}
                },{
                    {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
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
                return MySql.Sync.Fetch("player",{"Thirst"},{
                    {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                })[1].Thirst
            end,
            Set = function(value)
                MySql.Sync.Update("player",{
                    {Column = "Thirst" , Value = value}
                },{
                    {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
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
                return MySql.Sync.Fetch("player",{"Tiredness"},{
                    {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
                })[1].Tiredness
            end,
            Set = function(value)
                MySql.Sync.Update("player",{
                    {Column = "Tiredness" , Value = value}
                },{
                    {Method = "AND",Operator = "=",Column = "SteamID",Value = self.SteamID.Get()}
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
        }
    }
    return self
end)

Callback.RegisterServerCallback("wx_player_physiology_system:requestPhysiology",function(source)
    return {
        satiety = Player.GetPlayer(source):Physiology().Physiology.Satiety.Get(),
        thirst = Player.GetPlayer(source):Physiology().Physiology.Thirst.Get(),
        tiredness = Player.GetPlayer(source):Physiology().Physiology.Tiredness.Get()
    }
end)


Citizen.CreateThread(function()
    RegisterNativeHandler("testNative")
end)
