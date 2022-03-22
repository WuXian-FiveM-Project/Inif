TriggerEvent("RegisterModule","Utils",
{
    GenerateRandomFloat = function(min,max)
        min = math.floor(min)
        max = math.floor(max)
        math.randomseed(os.time()*math.random(min,max))
        return math.random(min,max) + math.random()
    end,
    GenerateRandomInt = function(min,max)
        math.randomseed(os.time()*math.random(0,1))
        return math.floor(math.random(min,max))
    end,
    GenerateRandomString = function(length)
        if length <= 0 then return "" end
        math.randomseed(os.time()*math.random(1,length)*length/4)
        local str = ""
        for i=1,length do
            str = str .. string.char(math.random(65,90))
        end
        return str
    end,
    GenerateRandomBoolean = function()
        math.randomseed(os.time()*math.random(1,2))
        return math.random(0,1) == 1
    end,
    Round = function(exact, quantum) --令数字取整
        return tonumber(tostring(exact):sub(1, tostring(exact):find('.') + quantum +1))
    end,
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
},true)

local Callback = exports.wx_module_system:RequestModule("Callback")

Callback.RegisterServerCallback("wx_utils:generateRandomFloat",function(source,min,max)
    local Utils = exports.wx_module_system:RequestModule("Utils")
    return Utils.GenerateRandomFloat(min,max)
end)

Callback.RegisterServerCallback("wx_utils:generateRandomInt",function(source,min,max)
    local Utils = exports.wx_module_system:RequestModule("Utils")
    return Utils.GenerateRandomInt(min,max)
end)

Callback.RegisterServerCallback("wx_utils:generateRandomString",function(source,length)
    local Utils = exports.wx_module_system:RequestModule("Utils")
    return Utils.GenerateRandomString(length)
end)
Callback.RegisterServerCallback("wx_utils:generateRandomBoolean",function(source,length)
    local Utils = exports.wx_module_system:RequestModule("Utils")
    return Utils.GenerateRandomBoolean()
end)