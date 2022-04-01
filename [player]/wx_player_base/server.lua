playerobj = {}
modulelist = {}

TriggerEvent("RegisterModule","Player",
    {
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
    },
    true
)

AddEventHandler('RegisterPlayerModule',function(ModuleName, Module)
    playerobj[ModuleName] = Module
    table.insert(modulelist,ModuleName)
end)

