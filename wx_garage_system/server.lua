--#region include
local Callback = exports.wx_module_system:RequestModule("Callback")
local MySql = exports.wx_module_system:RequestModule("MySql")
local Player = exports.wx_module_system:RequestModule("Player")
--#endregion

Callback.RegisterServerCallback("wx_garage_system:getGarageList", function()
    return {MySql.Sync.Query("SELECT * FROM garage",{})}
end)

Callback.RegisterServerCallback("wx_garage_system:getGarageVehicleList", function(src,locationGID)
    local returnV =  MySql.Sync.Query("SELECT *,UNIX_TIMESTAMP(cast(StoreDate as datetime))*1000 FROM garage_vehicle WHERE VehicleOwner=? AND VehicleGID=?",{
        GetPlayerIdentifier(src),
        locationGID
    })
    return {returnV}
end)

Callback.RegisterServerCallback("wx_garage_system:getCurrentMoney", function(src)
    local p = Player.GetPlayer(src)
    p = p:Inventory()
    if p.Inventory.IsItemExists("money") then
        return {p.Inventory.GetItem("money").Amount}
    else
        return {0}
    end
end)

Callback.RegisterServerCallback("wx_garage_system:getVehicleList", function(src)
    return MySql.Sync.Query("SELECT * FROM garage_vehicle")
end)


RegisterNetEvent("wx_garage_system:Rename", function(VID,NewName)
    MySql.Sync.Query("UPDATE garage_vehicle SET VehicleNickname=? WHERE VID=?",{
        NewName,
        tonumber(VID)
    })
end)


RegisterNetEvent("wx_garage_system:Pay", function(VID,Hours)
    local src = source
    local player = Player.GetPlayer(src)
    player = player:Inventory()
    local GID = MySql.Sync.Query("SELECT VehicleGID FROM garage_vehicle WHERE VID = ?",{
        tonumber(VID)
    })[1].VehicleGID
    local garageCost = MySql.Sync.Query("SELECT GarageCostPerHours FROM garage WHERE GID = ?",{
        tonumber(GID)
    })[1].GarageCostPerHours * tonumber(Hours)
    if player.Inventory.RemoveItem("money",garageCost) then
        MySql.Sync.Query("UPDATE garage_vehicle SET StoreDate=CURRENT_TIMESTAMP() WHERE VID=?",{
            tonumber(VID)
        })
    end
end)

Callback.RegisterServerCallback("wx_garage_system:Unlock",function(src,VID)
    TriggerClientEvent("wx_garage_system:destroyVehicle",-1,VID)
    local result = MySql.Sync.Query("SELECT * FROM garage_vehicle WHERE VID=? AND VehicleOwner = ?",{
        tonumber(VID),
        GetPlayerIdentifier(src)
    })[1]
    MySql.Sync.Query("DELETE FROM garage_vehicle WHERE VID=? AND VehicleOwner = ?",{
        tonumber(VID),
        GetPlayerIdentifier(src)
    })
    return result
end)

Callback.RegisterServerCallback("wx_garage_system:checkCanVehicleStoreInGarage", function(src,GID)
    local garage = MySql.Sync.Query("SELECT * FROM garage WHERE GID=?",{
        tonumber(GID)
    })[1]
    local currentVehicleCountInGarage = #MySql.Sync.Query("SELECT * FROM garage_vehicle WHERE VehicleGID=?",{
        tonumber(GID)
    })
    if garage.GarageMaxVehicleCanStore < currentVehicleCountInGarage then
        return "Full"
    end
end)

RegisterNetEvent("wx_garage_system:storeVehicle",function(GID,VehicleParms,VehicleModule,Plate,Position)
    local src = source

    MySql.Sync.Query("INSERT INTO garage_vehicle (VehicleGID,VehicleOwner,VehicleNickname,VehicleModule,VehicleParms,VehiclePlate,VehiclePosition,VehicleHeading) VALUES (?,?,?,?,?,?,?,?);",{
        tonumber(GID), --VehicleGID
        GetPlayerIdentifier(src), --VehicleOwner
        VehicleModule, --VehicleNickname
        VehicleModule, --VehicleModule
        json.encode(VehicleParms), --VehicleParms
        Plate, --VehiclePlate
        json.encode(Position), --VehiclePosition
        GetEntityHeading(GetPlayerPed(src)) --VehicleHeading
    })
    local result = MySql.Sync.Query("SELECT * FROM garage_vehicle WHERE VehicleGID =? AND VehicleParms =?",{
        tonumber(GID), --VehicleGID
        json.encode(VehicleParms), --VehicleParms
    })[1]
    TriggerClientEvent("wx_garage_system:updateVehicle",-1,result)
end)