TriggerEvent("RegisterApp", {
    IsSystemApp          = true,
    IsAppOverride        = true,
    AppName              = "应用商店",
    AppDescription       = "应用商店",
    AppPackageName       = "com.system.store",
    AppVersion           = "1.0.0",
    AppUrl               = "http://pokok.edu.hk",
    AppIcon              = "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
    AppAuthor            = "服主",
    AppAuthorUrl         = "",
    IsPaySoftware        = false,
    AppPrice             = 0.0,
    IsUploadToGooglePlay = true,
    IsUploadToAppStore   = true,
    AppSize              = 113000,
    onAppOpen            = function()
        return "dawd"
    end,
    onAppClose           = function() end,
    onAppInstall         = function() end,
    onAppUninstall       = function() end,
})

