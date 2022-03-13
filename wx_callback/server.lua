local Console = exports.wx_module_system:RequestModule("Console")

TriggerEvent("RegisterModule","Callback",{
    TriggerClientCallback = function (callbackName,playerid,...)
        math.randomseed(os.time()*math.random(1,999999)-os.time()/2)
        local returnName = math.random(1,999999)
        returnName = callbackName..tostring(math.random(1,999999))
        TriggerClientEvent("callback:"..callbackName, playerid, returnName,{...})
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
	RegisterServerCallback = function (callbackName,func)
        RegisterNetEvent('callback:'..callbackName,function(returnName,parms)
            local src = source
            local rtName
            local promise = promise.new()
            rtName = returnName
            local functionReturn = {func(src,table.unpack(parms))}
            promise:resolve(functionReturn)
            Citizen.Await(promise)
            TriggerClientEvent("callback:ServerReturn",src,rtName,functionReturn)
        end)
    end
},true)

RegisterNetEvent("callback:ClientReturn",function(returnName,parms)
    TriggerEvent(returnName,parms)
end)