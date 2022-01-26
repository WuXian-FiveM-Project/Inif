Citizen.CreateThread(function()
    SendNUIMessage({
        action = "Hide",
    })
    Wait(100)
    SendNUIMessage({
        action = "Show",
    })
    SendNUIMessage({
        action = "SetMenu",
        Menu = {
            {
                Type = "Title",
                Text = "Menu"
            },
            {
                Type = "Text",
                Text = "here is test menu"
            },
            {
                Type = "Button",
                Text = "test button",
            },
            {
                Type = "NumberInput",
                MaxValue = 100,
                MinValue = 0,
                DefaultValue = 50
            },
            {
                Type = "TextInput",
                Placeholder = "dwawdwd",
                DefaultValue = "w"
            },
            {
                Type = "Color"
            }
        }
    })
    SetNuiFocus(true, true)
end)


RegisterNUICallback("ButtonClick", function(data, cb)
    print(data.index)
end)