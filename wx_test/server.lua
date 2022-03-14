Citizen.CreateThread(function()
    Module.RegisterModule("NativeTest",{
        omg = function()
            return "omg it works"
        end
    })
    print(Module.LoadModule("NativeTest").omg())
end)