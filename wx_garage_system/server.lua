local MySql = exports.wx_module_system:RequestModule("MySql")
local Console = exports.wx_module_system:RequestModule("Console")

TriggerEvent("RegisterModule","Garage",{
    GetGarage = function(options)
        local GarageVehicle = exports.wx_module_system:RequestModule("GarageVehicle")
        local fetchRule,fetchName = "",""
        if options.GID then
            fetchRule = options.GID
            fetchName = "GID"
        elseif options.GarageName then
            fetchRule = options.GarageName
            fetchName = "GarageName"
        else
            Console.Error("Fail to get garage, miss options.GID or options.GarageName",true)
            return
        end
        local garage = MySql.Sync.Fetch("garage","*",{
            {Method = "AND",Operator = "=",Column = fetchName,Value = fetchRule}
        })
        
        local self = {}

        self.GID = {
            Get = function()
                return garage[1].GID
            end,
            Set = function(value)
                MySql.Sync.Update("garage",{
                    {Column = "GID",Value = value}
                },{
                    {Method = "AND",Column = "GID",Value = self.GID.Get(),Operator = "="}
                })
                garage[1].GID = value
                return value
            end
        }

        self.GarageName = {
            Get = function()
                return garage[1].GarageName
            end,
            Set = function(value)
                MySql.Sync.Update("garage",{
                    {Column = "GarageName",Value = value}
                },{
                    {Method = "AND",Column = "GID",Value = self.GID.Get(),Operator = "="}
                })
                garage[1].GarageName = value
                return value
            end
        }

        self.GaragePosition = {
            Get = function() --[[THIS FUNCTION RETURN VECTOR3！！1]]
                if type(garage[1].GaragePosition) == "table" then
                    return garage[1].GaragePosition
                else
                    return vec3(json.decode(garage[1].GaragePosition).x,json.decode(garage[1].GaragePosition).y,json.decode(garage[1].GaragePosition).z)
                end
            end,
            Set = function(value --[[THIS VALUE IS VECTOR3！！！！！]])
                assert(type(value) == "vector3","GaragePosition must be a vector3")
                MySql.Sync.Update("garage",{
                    {Column = "GaragePosition",Value = json.encode(value)}
                },{
                    {Method = "AND",Column = "GID",Value = self.GID.Get(),Operator = "="}
                })
                garage[1].GaragePosition = value
                return value
            end
        }

        self.GarageMaxVehicleCanStore = {
            Get = function()
                return garage[1].GarageMaxVehicleCanStore
            end,
            Set = function(value)
                MySql.Sync.Update("garage",{
                    {Column = "GarageMaxVehicleCanStore",Value = value}
                },{
                    {Method = "AND",Column = "GID",Value = self.GID.Get(),Operator = "="}
                })
                garage[1].GarageMaxVehicleCanStore = value
                return value
            end
        }

        ---get all vehicle in garage
        ---@return table List (GarageVehicle list) list of vehicle 
        self.GetAllVehicleInGarage = function()
            local returnValue = MySql.Sync.FetchAll("garage_vehicle")
            local result = {}
            for k,v in pairs(returnValue) do
                table.insert(result,GarageVehicle.GetGarageVehicle({VID = v.VID}))
            end
            return result
        end

        ---get all vehicle in garage via steamID
        ---@param steamID string SteamID
        ---@return table List List (list :GarageVehicle) list of vehicle
        self.GetVehiclesViaSteamID = function(steamID)
            local returnValue = MySql.Sync.Fetch("garage_vehicle","*",{
                {Method = "AND",Operator = "=",Column = "VehicleOwner",Value = steamID}
            })
            local result = {}
            for k,v in pairs(returnValue) do
                table.insert(result,GarageVehicle.GetGarageVehicle({VID = v.VID}))
            end
            return result
        end
        ---get all vehicle in garage via Module
        ---@param vehicleModule string vehicleModule
        ---@return table List List (list :GarageVehicle) list of vehicle
        self.GetVehiclesViaVehicleModule = function(vehicleModule)
            local returnValue = MySql.Sync.Fetch("garage_vehicle","*",{
                {Method = "AND",Operator = "=",Column = "VehicleModule",Value = vehicleModule}
            })
            local result = {}
            for k,v in pairs(returnValue) do
                table.insert(result,GarageVehicle.GetGarageVehicle({VID = v.VID}))
            end
            return result
        end

        self.GetVehicleViaVehiclePlate = function(vehicleModule)
            local returnValue = MySql.Sync.Fetch("garage_vehicle","*",{
                {Method = "AND",Operator = "=",Column = "VehicleModule",Value = vehicleModule}
            })[1]
            return GarageVehicle.GetGarageVehicle({VID = returnValue.VID})
        end

        self.AddVehicle = function(options)
            assert(options.VehicleOwner,"VehicleOwner is required")
            assert(options.VehicleModule,"VehicleModule is required")
            options.VehicleParms = options.VehicleParms or {}
            assert(options.VehiclePlate,"VehiclePlate is required")
            assert(options.VehiclePosition,"VehiclePosition is required")
            assert(options.VehicleHeading,"VehicleHeading is required")
            MySql.Sync.Insert("garage_vehicle",{
                {Column = "VehicleGID" , Value = self.GID.Get()},
                {Column = "VehicleOwner" , Value = options.VehicleOwner},
                {Column = "VehicleModule" , Value = options.VehicleModule},
                {Column = "VehicleParms" , Value = json.encode(options.VehicleParms)},
                {Column = "VehiclePlate" , Value = options.VehiclePlate},
                {Column = "VehiclePosition" , Value = json.encode(options.VehiclePosition)},
                {Column = "VehicleHeading" , Value = options.VehicleHeading}
            })
            return MySql.Sync.Fetch("garage_vehicle","*",{
                {Method = "AND",Operator = "=",Column = "VehiclePlate",Value = options.VehiclePlate}
            })[1]
        end

        return self
    end,
    ---get all garage
    ---@return table List List of {{VID , GarageName},{VID , GarageName},{VID , GarageName}}
    GetGarages = function()
        return MySql.Sync.FetchAll("garage")
    end,
},true)

local MySql = exports.wx_module_system:RequestModule("MySql")
local Console = exports.wx_module_system:RequestModule("Console")

TriggerEvent("RegisterModule","GarageVehicle",{
    GetGarageVehicle = function(options)
        local fetchRule,fetchName = "",""
        if options.VID then
            fetchRule = options.VID
            fetchName = "VID"
        elseif options.VehiclePlate then
            fetchRule = options.VehiclePlate
            fetchName = "VehiclePlate"
        else
            Console.Error("Fail to get garage vehicle, miss options.VID or options.VehiclePlate",true)
            return
        end
        local garageVehicle = MySql.Sync.Fetch("garage_vehicle","*",{
            {Method = "AND",Operator = "=",Column = fetchName,Value = fetchRule}
        })

        local self = {}
        self.VID = {
            Get = function()
                return garageVehicle[1].VID
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VID",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VID = value
                return value
            end
        }

        self.VehicleGID = {
            Get = function()
                return garageVehicle[1].VehicleGID
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehicleGID",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehicleGID = value
                return value
            end
        }

        self.VehicleOwner = {
            Get = function()
                return garageVehicle[1].VehicleOwner
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehicleOwner",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehicleOwner = value
                return value
            end
        }

        self.VehicleModule = {
            Get = function()
                return garageVehicle[1].VehicleModule
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehicleModule",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehicleModule = value
                return value
            end
        }

        self.VehicleParms = {
            Get = function()
                return json.decode(garageVehicle[1].VehicleParms)
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehicleParms",Value = json.encode(value)}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehicleParms = json.encode(value)
                return value
            end
        }

        self.VehiclePlate = {
            Get = function()
                return garageVehicle[1].VehiclePlate
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehiclePlate",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehiclePlate = value
                return value
            end
        }

        self.VehiclePosition = {
            Get = function()
                return vec3(json.decode(garageVehicle[1].VehiclePosition).x,json.decode(garageVehicle[1].VehiclePosition).y,json.decode(garageVehicle[1].VehiclePosition).z)
            end,
            Set = function(value)
                assert(type(value) == "vector3","VehiclePosition must be vector3")
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehiclePosition",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehiclePosition = value
                return value
            end
        }

        self.StoreDate = {
            Get = function()--[[return a unix timestamp]]
                return garageVehicle[1].StoreDate
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "StoreDate",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].StoreDate = value
                return value
            end
        }

        self.VehicleHeading = {
            Get = function()
                return garageVehicle[1].VehicleHeading
            end,
            Set = function(value)
                MySql.Sync.Update("garage_vehicle",{
                    {Column = "VehicleHeading",Value = value}
                },{
                    {Method = "AND",Column = "VID",Value = self.VID.Get(),Operator = "="}
                })
                garageVehicle[1].VehicleHeading = value
                return value
            end
        }

        return self
    end,
    ---get all garage
    ---@return table List List of {{VID , GID},{VID , GID},{VID , GID}}
    GetAllVehicles = function()
        return MySql.Sync.FetchAll("garage_vehicle")
    end,
},true)
local garageVehicleList = {}

Citizen.CreateThread(function()
    local GarageVehicle = exports.wx_module_system:RequestModule("GarageVehicle")
    local garageVehicles = GarageVehicle.GetAllVehicles()
    local garage_Vehicle = {}
    for _,v in ipairs(garageVehicles) do
        table.insert(garage_Vehicle,GarageVehicle.GetGarageVehicle({VID=v.VID}))
    end
    for _,v in ipairs(garage_Vehicle) do
        SpawnVehicleInGarage(v.VID.Get(),GetHashKey(v.VehicleModule.Get()),v.VehiclePosition.Get(),v.VehicleHeading.Get(),v.VehiclePlate.Get())
    end
end)

RegisterNetEvent("wx_garage:frBoost",function()
    local GarageVehicle = exports.wx_module_system:RequestModule("GarageVehicle")
    local garageVehicles = GarageVehicle.GetAllVehicles()
    local garage_Vehicle = {}
    for _,v in ipairs(garageVehicles) do
        table.insert(garage_Vehicle,GarageVehicle.GetGarageVehicle({VID=v.VID}))
    end
    for _,v in ipairs(garage_Vehicle) do
        SpawnVehicleInGarage(v.VID.Get(),GetHashKey(v.VehicleModule.Get()),v.VehiclePosition.Get(),v.VehicleHeading.Get(),v.VehiclePlate.Get())
    end
end)

function SpawnVehicleInGarage(VID,vehiclehash,position,heading,plate,parms)
    local vehicleObj
    while type(vehicleObj) == "nil" do
        vehicleObj = CreateVehicle(
            vehiclehash --[[ Hash ]],
	    	position.x+0.001 --[[ number ]],
	    	position.y+0.001 --[[ number ]],
	    	position.z+0.001 --[[ number ]],
	    	true --[[ boolean ]],
	    	true --[[ boolean ]],
	    	false --[[ boolean ]]
	    )
    end
    garageVehicleList[VID] = vehicleObj
    SetEntityHeading(
    	vehicleObj --[[ Entity ]],
    	heading+0.001 --[[ number ]]
    )
    SetVehicleDoorsLocked(
    	vehicleObj --[[ Vehicle ]],
    	2 --[[ integer ]]
    )
    SetVehicleNumberPlateText(
    	vehicleObj --[[ Vehicle ]], 
    	plate --[[ string ]]
    )
    SetVehicleProperties = function(vehicle, props)
    	if DoesEntityExist(vehicle) then
    		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
    		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    		SetVehicleModKit(vehicle, 0)

    		if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
    		if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
    		if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
    		if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
    		if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
    		if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
    		if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
    		if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
    		if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
    		if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
    		if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
    		if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
    		if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end

    		if props.neonEnabled then
    			SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
    			SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
    			SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
    			SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
    		end

    		if props.extras then
    			for extraId,enabled in pairs(props.extras) do
    				if enabled then
    					SetVehicleExtra(vehicle, tonumber(extraId), 0)
    				else
    					SetVehicleExtra(vehicle, tonumber(extraId), 1)
    				end
    			end
    		end

    		if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
    		if props.xenonColor then SetVehicleXenonLightsColor(vehicle, props.xenonColor) end
    		if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
    		if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
    		if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
    		if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
    		if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
    		if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
    		if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
    		if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
    		if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
    		if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
    		if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
    		if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
    		if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
    		if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
    		if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
    		if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
    		if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
    		if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
    		if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
    		if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) end
    		if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) end
    		if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
    		if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
    		if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
    		if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
    		if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
    		if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
    		if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
    		if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
    		if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
    		if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
    		if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
    		if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
    		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
    		if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
    		if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
    		if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
    		if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
    		if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
    		if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
    		if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
    		if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
    		if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
    		if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
    		if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end

    		if props.modLivery then
    			SetVehicleMod(vehicle, 48, props.modLivery, false)
    			SetVehicleLivery(vehicle, props.modLivery)
    		end
    	end
    end
    SetVehicleProperties(vehicleObj, parms)
    Wait(100)
    UpdateVehiclePropsForClient()
end

function UpdateVehiclePropsForClient(clientID)
    local prop = {}
    local GarageVehicle = exports.wx_module_system:RequestModule("GarageVehicle")
    for k,v in pairs(garageVehicleList) do
        print(k,v)
        table.insert(
            prop,
            {
                Vehicle = tonumber(v),
                Props = GarageVehicle.GetGarageVehicle({VID = k}).VehicleParms.Get()
            }
        )
    end
    TriggerClientEvent("wx_garage:setVehicleProps",clientID or -1,prop)
end

RegisterNetEvent('requestVehicleProp', function()
    UpdateVehiclePropsForClient(source)
end)

AddEventHandler("playerJoining", function()
    UpdateVehiclePropsForClient(source)
end)

RegisterNetEvent("wx_garage:depositCar",function(modlename,GID,plate,parms)
    local Garage = exports.wx_module_system:RequestModule("Garage")
    local src = source
    local garage = Garage.GetGarage({GID=GID})
    local adV = garage.AddVehicle({
        VehicleOwner=GetPlayerIdentifier(src),
        VehicleModule=modlename,
        VehicleParms=parms,
        VehiclePlate=plate,
        VehiclePosition=GetEntityCoords(GetPlayerPed(src)),
        VehicleHeading = GetEntityHeading(GetVehiclePedIsIn(GetPlayerPed(src),false))
    })
    local gtpi = GetVehiclePedIsIn(GetPlayerPed(src),false)
    local gtpiH = GetEntityHeading(gtpi)
    local gtpiC = GetEntityCoords(GetPlayerPed(src))
    DeleteEntity(GetVehiclePedIsIn(GetPlayerPed(src),false))
    Wait(100)
    SpawnVehicleInGarage(adV.VID,GetHashKey(modlename),gtpiC,gtpiH,plate,parms)
end)