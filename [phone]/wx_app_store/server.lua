TriggerEvent("RegisterApp", {
    IsSystemApp          = true,
    IsAppOverride        = true,
    AppName              = "Google Play",
    AppDescription       = "Google Play",
    AppPackageName       = "com.system.google.store",
    AppVersion           = "1.0.0",
    AppUrl               = "nui://"..GetCurrentResourceName().."/index.html",
    AppIcon              = "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
    AppAuthor            = "服主",
    AppAuthorUrl         = "",
    IsPaySoftware        = false,
    AppPrice             = 0.0,
    IsUploadToGooglePlay = true,
    IsUploadToAppStore   = true,
    AppSize              = 59000,
    onAppOpen            = function()
        return "dawd"
    end,
    onAppClose     = function() end,
    onAppInstall   = function() end,
    onAppUninstall = function() end,
})

