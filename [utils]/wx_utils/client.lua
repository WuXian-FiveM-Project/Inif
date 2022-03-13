local Callback = exports.wx_module_system:RequestModule("Callback")

TriggerEvent("RegisterModule","Utils",
{
    GenerateRandomFloat = function(min,max)
        return Callback.TriggerServerCallback("wx_utils:generateRandomFloat",min,max)
    end,
    GenerateRandomInt = function(min,max)
        return Callback.TriggerServerCallback("wx_utils:generateRandomInt",min,max)
    end,
    GenerateRandomString = function(length)
        return Callback.TriggerServerCallback("wx_utils:generateRandomString",length)
    end,
    GenerateRandomBoolean = function()
        return Callback.TriggerServerCallback("wx_utils:generateRandomBoolean")
    end,
    GetEntityPointingAt = function(entity)
        return (GetOffsetFromEntityInWorldCoords(entity,0.0,10000.0,0.0)-GetEntityCoords(entity))
    end,
    Round = function(exact, quantum) --令数字取整
        return tonumber(tostring(exact):sub(1, tostring(exact):find('.') + quantum +1))
    end
},true)