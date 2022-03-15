TriggerEvent("RegisterModule","Utils",
{
    GenerateRandomFloat = function(min,max)
        min = math.floor(min)
        max = math.floor(max)
        math.randomseed(os.time()*math.random(min,max))
        return math.random(min,max) + math.random()
    end,
    GenerateRandomInt = function(min,max)
        math.randomseed(os.time()*math.random(min,max))
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