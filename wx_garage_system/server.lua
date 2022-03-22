--#region include
local Callback = exports.wx_module_system:RequestModule("Callback")
local MySql = exports.wx_module_system:RequestModule("MySql")
local Player = exports.wx_module_system:RequestModule("Player")
--#endregion

Callback.RegisterServerCallback("wx_garage_system:getGarageList", function()
    return MySql.Sync.Query("SELECT * FROM garage")
end)
Callback.RegisterServerCallback("wx_garage_system:getGarageVehicleList", function(src)
    local returnV =  MySql.Sync.Query("SELECT * FROM garage_vehicle WHERE VehicleOwner=?",{
        GetPlayerIdentifier(src)
    })
    returnV.price = os.time() - returnV.StoreDate
    return returnV
end)
Callback.RegisterServerCallback("wx_garage_system:getCurrentMoney", function(src)
    local p = Player.GetPlayer(src)
    p = p:Inventory()
    return p.Inventory.GetItem("money").Amount
end)