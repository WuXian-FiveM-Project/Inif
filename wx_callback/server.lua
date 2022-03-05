local Console = exports.wx_module_system:RequestModule("Console")

TriggerEvent("RegisterModule","Callback",{
    TriggerClientCallback = function (callbackName,playerid,...)
        math.randomseed(os.time()*math.random(1,999999)-os.time()/2)
        local returnName = math.random(1,999999)
        returnName = tostring(math.random(1,999999))
        TriggerClientEvent(callbackName, playerid, returnName,{...})

        local promise = promise.new()
        local returnValue = nil
        local handle = AddEventHandler(returnName,function(...)
            returnValue = {...}
            promise:resolve(...)
        end)
        Citizen.Await(promise)
		RemoveEventHandler(handle)
        Console.Log("Trigger Client Callback"..", ID : "..playerid.."  Callback Name : "..callbackName)
        return table.unpack(returnValue)
    end,
	RegisterServerCallback = function (callbackName,func)
        RegisterNetEvent(callbackName,function(return_callbackName,...)
			local _source = source
            local returnValue
			local promise = promise.new()
			local arg = ...
			Citizen.CreateThread(function()
				returnValue = {func(_source,table.unpack(arg))}
				promise:resolve(returnValue)
			end)
			Citizen.Await(promise)
            TriggerClientEvent("CallbackCall",_source,return_callbackName,returnValue)
        end)
    end
},true)

RegisterNetEvent('CallbackCall',function(callbackName,...)
    TriggerEvent(callbackName,table.unpack(...))
end)