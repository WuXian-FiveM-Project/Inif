Citizen.CreateThread(function()
    Wait(1000)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "showPhone",
        phoneData = {
            PID           = 1,
            PhonePassword = "123",
            PhoneModule   = "iPhone X",
            PhoneSetting  = {
                DarkMode = true,
            },
            PhoneApps= {
                {
                    IsSystemApp    = true,
                    IsAppOverride  = true,
                    AppName        = "应用商店",
                    AppDescription = "应用商店",
                    AppPackageName = "com.system.store",
                    AppVersion     = "1.0.0",
                    AppUrl         = "http://pokok.edu.hk",
                    AppIcon        =
                        "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
                    AppAuthor            = "服主",
                    IsPaySoftware        = false,
                    AppPrice             = 0,
                    IsUploadToGooglePlay = true,
                    IsUploadToAppStore   = true,
                    AppAuthorAuthor      = "",
                    AppSize              = 113000,
                },
            },
            PhoneData            = {},
            PhoneRegisterDate    = 1,
            PhoneMaxCapacity     = 128000000,
            PhoneCurrentCapacity = 226000,
        }}
    )
end)

RegisterNUICallback('HideCurse', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('wx_phone:showPhone', function(phoneData)
    SetNuiFocus(true, true)
    print(json.encode(phoneData))
    SendNUIMessage({
        type = "showPhone",
        phoneData = phoneData
    })
end)
