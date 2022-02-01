Console = exports.wx_module_system:RequestModule("Console")
Callback = exports.wx_module_system:RequestModule("Callback")
Player = exports.wx_module_system:RequestModule("Player")
MySql = exports.wx_module_system:RequestModule("MySql")

Callback.RegisterServerCallback("testserver",function(arg1,arg2)
    print("print args "..arg1,arg2)
    return "this is server return",1
end)

Citizen.CreateThread(function()
    -- Console.Test("awwdaw")
    -- print(json.encode(MySql.Sync.Update("player",
    --     {
    --         {Column = "PID" , Value = 1000 },
    --         {Column = "Name" , Value = 10000 }
    --     },
    --     {
    --         {Method = "And" ,Column = "PID" , Value = 1000  , Operator = "="},
    --         {Method = "And" ,Column = "Name" , Value = 10000  , Operator = "="}
    --     }
    -- )))
    -- Callback.RegisterServerCallback("test",function(src,par)
    --     return src
    -- end)
    local a = Player.GetPlayer(GetPlayers()[1])
    print(json.encode(a.SteamID.Get()))
    Wait(100)
    -- print("client reutnr value : "..Callback.TriggerClientCallback("test",1,"ar1","ar2"))
    a = a:Coords() --获得Coords这个module 并且将里面的对象拷贝到a里面
    a.Coords.Set(1,2,75)
    a = a:Rotation() --获得Rotation 并且将里面的对象拷贝到a里面
    a.Rotation.Set(10,50,10)
    a = a:Notification()
    --Wait(100)
    --a.Notification.ShowBreakingNews("daw","sdadsdads","nil",1000)
    --a.Notification.ShowPopupWarning("你已被封禁","hhh","开玩笑的",1000)
    --a.Notification.ShowAdvancedNotification(a.PlayerID.Get(),"wdk2wad","twdwd2witle","edwddw",2,2)
    --Wait(1000)
    --a.Notification.ShowFloatingHelpNotification("daw",GetEntityCoords(GetPlayerPed(a.PlayerID.Get())),5000)
    a = a:Inventory()
    print(json.encode(a.Inventory.DropItem("water",1)))

end)