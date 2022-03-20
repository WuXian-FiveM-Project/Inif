--#region include
Callback = exports.wx_module_system:RequestModule("Callback")
MySql = exports.wx_module_system:RequestModule("MySql")
Player = exports.wx_module_system:RequestModule("Player")
--#endregion

Callback.RegisterServerCallback("wx_garage_system:getGarageList", function()
    return MySql.Sync.FetchAll("garage")
end)
Callback.RegisterServerCallback("wx_garage_system:getGarageVehicleList", function(src)
    local returnV =  MySql.Sync.Fetch("garage_vehicle","*",{
        {Method = "AND",Operator = "=",Column = "VehicleOwner",Value = GetPlayerIdentifier(src)}
    })
    returnV.price = os.time() - returnV.StoreDate 
    return returnV
end)
Callback.RegisterServerCallback("wx_garage_system:getCurrentMoney", function(src)
    local p = Player.GetPlayer(src)
    p = p:Inventory()
    return p.Inventory.GetItem("money").Amount
end)