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
},true)