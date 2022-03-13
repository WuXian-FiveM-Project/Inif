Callback = exports.wx_module_system:RequestModule("Callback")


Callback.RegisterClientCallback("test",function(arg1,arg2)
    print("print args :"..arg1,arg2)
    Wait(1000)
    return "this is from client return",1,100
end)

Citizen.CreateThread(function()
    -- print("server return value :"..Callback.TriggerServerCallback("testserver","sss","ar2"))
end)