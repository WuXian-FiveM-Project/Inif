TriggerEvent("RegisterModule","Callback",{
    TriggerClientCallback = function (callbackName,playerid,...)
        local tempEventHandler
        local ticket = os.time()
        TriggerClientEvent("__Callback:S->C:TriggerClientCallback",playerid,callbackName,ticket,table.pack(...))
        local awaitPromise = promise.new()
        
        tempEventHandler = AddEventHandler("__TriggerCallbackHandler"..callbackName..ticket,function(result)
            awaitPromise:resolve(result)
        end)
        local result = Citizen.Await(awaitPromise)
        RemoveEventHandler(tempEventHandler)
        return table.unpack(result)
    end,
	RegisterServerCallback = function (callbackName,func)
        AddEventHandler('__ServerInsideCallback'..callbackName,function(callbackFunction,source,parms)
            parms[1] = parms[1] or ""
            local result = {(func(source,table.unpack(parms)))}
            callbackFunction(result)
        end)
    end,
},true)

RegisterNetEvent("__Callback:C->S:TriggerServerCallback",function(eventName,ticket,parms)
    local src = source
    local awaitPromise = promise.new()
    TriggerEvent("__ServerInsideCallback"..eventName,function(result)
        awaitPromise:resolve(result)
    end,src,parms)
    
    local result = Citizen.Await(awaitPromise)

    TriggerClientEvent("__Callback:S->C:TriggerServerCallback:Return",src,eventName..ticket,result)
end)

RegisterNetEvent("__Callback:C->S:TriggerClientCallback:Return",function(eventNameAndTicket,result)
    TriggerEvent("__TriggerCallbackHandler"..eventNameAndTicket,result)
end)