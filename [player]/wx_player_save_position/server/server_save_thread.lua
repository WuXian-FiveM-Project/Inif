local Player = exports.wx_module_system:RequestModule("Player")
local Console = exports.wx_module_system:RequestModule("Console")

local playerInWorldList = {}

Citizen.CreateThread(function()
    while true do
        local players = Player.GetAllPlayers()
        for _,v in pairs(players) do
            if playerInWorldList[tostring(v.PlayerID.Get())] then
                v = v:LastPosition()
                v.LastPosition.Set(GetEntityCoords(GetPlayerPed(v.PlayerID.Get())))
                Console.Log("saveing player " .. v.SteamID.Get() .. " position(".. json.encode(GetEntityCoords(GetPlayerPed(v.PlayerID.Get()))) .. ")",true)
            end
        end
        Citizen.Wait(10000)
    end
end)

RegisterNetEvent("wx_player_save_position:spawn",function ()
    local src = source
    local player = Player.GetPlayer(src)
    player = player:LastPosition()
    SetEntityCoords(
        GetPlayerPed(src),
        player.LastPosition.Get(),
        true,
        false,
        0,
        false
    )
    Wait(1000)
    playerInWorldList[tostring(src)] = true
end)