MySql = exports.wx_module_system:RequestModule("MySql")
Console = exports.wx_module_system:RequestModule("Console")
Player = exports.wx_module_system:RequestModule("Player")
Callback = exports.wx_module_system:RequestModule("Callback")
Utils = exports.wx_module_system:RequestModule("Utils")

TriggerEvent("RegisterPlayerModule","Physiology",function(self) --self 是隐式参数 self = Player.GetPlayer(
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
    return self
end)

Callback.RegisterServerCallback("wx_player_physiology_system:requestPhysiology",function(source)
    local p = Player.GetPlayer(source):Physiology().Physiology
    return {
        satiety = p.Satiety.Get(),
        thirst = p.Thirst.Get(),
        tiredness = p.Tiredness.Get(),
        urine = p.Urine.Get(),
        shit = p.Shit.Get()
    }
end)

RegisterNetEvent("wx_player_physiology_system:createInstance",function()
    local src = source

    Citizen.CreateThread(function()
        local player = Player.GetPlayer(src)
        player = player:Physiology()
        while true do
            if GetPlayerPed(src) == 0 then
                break
            end
            Wait(30000)
            if GetPlayerPed(src) == 0 then
                break
            end
            player.Physiology.Satiety.Remove(Utils.Round(Utils.GenerateRandomFloat(1,2),2))
            player.Physiology.Shit.Add(Utils.Round(Utils.GenerateRandomFloat(1,2),2))
            player.Physiology.Thirst.Remove(Utils.Round(Utils.GenerateRandomFloat(1,5),2))
            player.Physiology.Urine.Add(Utils.Round(Utils.GenerateRandomFloat(1,5),2))
            player.Physiology.Tiredness.Remove(Utils.Round(Utils.GenerateRandomFloat(0,1),2))
        end
    end)

    Citizen.CreateThread(function()
        local player = Player.GetPlayer(src)
        player = player:Physiology()
        local loopDelay = Utils.GenerateRandomInt(1000,math.floor(player.Physiology.Tiredness.Get()*1000))
        while true do
            if GetPlayerPed(src) == 0 then
                break
            end
            Wait(loopDelay)
            local tr = player.Physiology.Tiredness.Get()
            if GetPlayerPed(src) == 0 then
                break
            end
            if tr < 25 then
                TriggerClientEvent("wx_player_physiology_system:doTirednessBlackOut",src,tr)
            end
            loopDelay = Utils.GenerateRandomInt(1000,math.floor(tr)*1000)
        end
    end)

    Citizen.CreateThread(function()
        local player = Player.GetPlayer(src)
        player = player:Physiology()
        local loopDelay = Utils.GenerateRandomInt(1000,math.floor(player.Physiology.Satiety.Get())*1000)
        while true do
            if GetPlayerPed(src) == 0 then
                break
            end
            Wait(loopDelay)
            local so = player.Physiology.Satiety.Get()
            if GetPlayerPed(src) == 0 then
                break
            end
            if so < 25 then
                TriggerClientEvent("wx_player_physiology_system:doSatietyBlackOut",src,so)
                if so < 5 then
                    ApplyDamageToPed(
                    	GetPlayerPed(src) --[[ Ped ]], 
                    	math.floor((100 - so)*0.01) --[[ integer ]], 
                    	true --[[ boolean ]]
                    )
                end
            end
            loopDelay = Utils.GenerateRandomInt(1000,math.floor(so)*1000)
        end
    end)

    Citizen.CreateThread(function()
        local player = Player.GetPlayer(src)
        player = player:Physiology()
        local loopDelay = Utils.GenerateRandomInt(1000,math.floor(player.Physiology.Thirst.Get())*1000)
        while true do
            if GetPlayerPed(src) == 0 then
                break
            end
            Wait(loopDelay)
            local tr = player.Physiology.Thirst.Get()
            if GetPlayerPed(src) == 0 then
                break
            end
            if tr < 25 then
                TriggerClientEvent("wx_player_physiology_system:doTirednessBlackOut",src,tr)
                TriggerClientEvent("wx_player_physiology_system:doSatietyBlackOut",src,tr)
                if tr < 5 then
                    ApplyDamageToPed(
                    	GetPlayerPed(src) --[[ Ped ]], 
                    	math.floor((100 - tr)*0.01) --[[ integer ]], 
                    	true --[[ boolean ]]
                    )
                end
            end
            loopDelay = Utils.GenerateRandomInt(1000,math.floor(tr)*1000)
        end
    end)

end)

Citizen.CreateThread(function()
    print(json.encode(testNative()))
end)

RegisterNetEvent("wx_player_physiology_system:goPee",function()
    local src = source
    local p = Player.GetPlayer(src):Physiology().Physiology
    local r = Utils.Round(Utils.GenerateRandomFloat(math.min(p.Urine.Get(),10),p.Urine.Get()),2)
    p.Urine.Remove(r)
end)

RegisterNetEvent("wx_player_physiology_system:goShit",function()
    local src = source
    local p = Player.GetPlayer(src):Physiology().Physiology
    local r = Utils.Round(Utils.GenerateRandomFloat(math.min(p.Shit.Get(),10),p.Shit.Get()),2)
    p.Shit.Remove(r)
end)