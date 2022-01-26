local module_list = {}

AddEventHandler("RegisterModule",function (modulename,module,isOverride)
    if type(module_list[modulename]) ~= "nil" then
        if isOverride then
            module_list[modulename] = module
        else
            error("module \""..modulename.."\" already registered if overide then fill true in the third parameter")
        end
    else
        module_list[modulename] = module
    end
end)

AddEventHandler("RequestModule",function (modulename,func)
    if type(module_list[modulename]) == "nil" then
        error("No module call "..modulename)
        func(nil)
    else
        func(module_list[modulename])
    end
end)

exports('RequestModule', function(modulename)
    if type(module_list[modulename]) == "nil" then
        error("No module call "..modulename)
        return nil
    else
        return module_list[modulename]
    end
end)