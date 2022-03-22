TriggerEvent("RegisterModule","Callback",{
    RegisterClientCallback = function (callbackName,func)
        AddEventHandler('__ClientInsideCallback'..callbackName,function(callbackFunction,parms)
            parms[1] = parms[1] or ""
            local result = {(func(table.unpack(parms)))}
            callbackFunction(result)
        end)
    end,
	TriggerServerCallback = function (callbackName,...)
        local tempEventHandler
        local ticket = GetGameTimer()
        local awaitPromise = promise.new()
        TriggerServerEvent("__Callback:C->S:TriggerServerCallback",callbackName,ticket,table.pack(...))
        tempEventHandler = AddEventHandler("__TriggerCallbackHandler"..callbackName..ticket,function(result)
            awaitPromise:resolve(result)
        end)
        local result = Citizen.Await(awaitPromise)
        RemoveEventHandler(tempEventHandler)
        return table.unpack(result)
    end,
},true)

RegisterNetEvent("__Callback:S->C:TriggerServerCallback:Return",function(eventNameAndTicket,result)
    TriggerEvent("__TriggerCallbackHandler"..eventNameAndTicket,result)
end)

RegisterNetEvent("__Callback:S->C:TriggerClientCallback",function(eventName,ticket,parms)
    local awaitPromise = promise.new()

    TriggerEvent("__ClientInsideCallback"..eventName,function(result)
        awaitPromise:resolve(result)
    end,parms)
    
    local result = Citizen.Await(awaitPromise)

    TriggerServerEvent("__Callback:C->S:TriggerClientCallback:Return",eventName..ticket,result)
end)