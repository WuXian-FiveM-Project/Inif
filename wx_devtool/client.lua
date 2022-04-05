

RegisterCommand('crun',function(source,args,rawCommand)
    --splite all space to table
    local args = {}
    for word in string.gmatch(rawCommand, "[^%s]+") do
        table.insert(args, word)
    end
    local loop = true
    local breakHandler
    breakHandler = AddEventHandler('break',function()
        loop = false
    end)

    if args[3] ~= nil then
        if args[4] then
            Citizen.CreateThread(function()
                print("Loop Run:",args[2], "with delay", args[4])
                while loop do
                    Wait(tonumber(args[4]))
                    print("Status Code:",pcall(load(args[2])))
                end
                RemoveEventHandler(breakHandler)
            end)
        end
    elseif args[2] then
        print("Run:",args[2])
        print("Status Code:",pcall(load(args[2])))
        RemoveEventHandler(breakHandler)
    end
end)

RegisterCommand("break",function(source,args,rawCommand)
    TriggerEvent("break")
end)