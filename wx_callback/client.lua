TriggerEvent("RegisterModule","Callback",{
    RegisterClientCallback = function (callbackName,func)
        RegisterNetEvent('callback:'..callbackName,function(returnName,parms)
            local rtName
            local promise = promise.new()
            rtName = returnName
            local functionReturn = {func(table.unpack(parms))}
            promise:resolve(functionReturn)
            Citizen.Await(promise)
            TriggerServerEvent("callback:ClientReturn",rtName,functionReturn)
        end)
    end,
	TriggerServerCallback = function (callbackName,...)
        local returnName = math.random(1,999999)
        returnName = callbackName..tostring(math.random(1,999999))
        TriggerServerEvent("callback:"..callbackName, returnName,{...})
        local handle
        local waitPromise = promise.new()
        local returnValue
        handle = AddEventHandler(returnName,function(parms)
            RemoveEventHandler(handle)
            returnValue = parms
            waitPromise:resolve(parms)
        end)
        Citizen.Await(waitPromise)
        return table.unpack(returnValue)
    end,
},true)

RegisterNetEvent("callback:ServerReturn",function(returnName,parms)
    TriggerEvent(returnName,parms)
end)