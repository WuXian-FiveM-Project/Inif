TriggerEvent("RegisterModule","Callback",{
    RegisterClientCallback = function (callbackName,func)
        RegisterNetEvent(callbackName,function(return_callbackName,...)
            local retunrValue
			local promise = promise.new()
			local arg = ...
			Citizen.CreateThread(function()
				retunrValue = {func(table.unpack(arg))}
				promise:resolve(retunrValue)
			end)
			Citizen.Await(promise)
            TriggerServerEvent("CallbackCall",return_callbackName,retunrValue)
        end)
    end,
	TriggerServerCallback = function (callbackName,...)
        local returnName = math.random(1,999999)
        returnName = tostring(math.random(1,999999))
        TriggerServerEvent(callbackName, returnName,{...})

        local promise = promise.new()
        local returnValue = nil
        local handle = AddEventHandler(returnName,function(...)
            returnValue = {...}
            promise:resolve(...)
        end)
        Citizen.Await(promise)
		RemoveEventHandler(handle)
        return table.unpack(returnValue)
    end,
},true)

RegisterNetEvent('CallbackCall',function(callbackName,...)
    TriggerEvent(callbackName,table.unpack(...))
end)