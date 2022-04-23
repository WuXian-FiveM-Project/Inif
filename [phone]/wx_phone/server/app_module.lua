---@class App
appclass = {
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
    onAppOpen            = function(PID) end,
    onAppClose           = function(PID) end,
    onAppInstall         = function(PID) end,
    onAppUninstall       = function(PID) end,
}

local appList = {}
local appIndex = {}


AddEventHandler("RegisterApp", function(appClass)
    --#region assert all parameters type are valid (app)
    assert(type(appClass) == "table", "appClass must be a table")
    assert(type(appClass.AppName) == "string", "appClass.AppName must be a string")
    appClass.AppDescription = appClass.AppDescription or ""
    assert(type(appClass.AppDescription) == "string", "appClass.AppDescription must be a string")
    assert(type(appClass.AppPackageName) == "string", "appClass.AppPackageName must be a string")
    appClass.AppVersion = appClass.AppVersion or "1.0"
    assert(type(appClass.AppVersion) == "string", "appClass.AppVersion must be a string")
    appClass.AppUrl = appClass.AppUrl or ""
    assert(type(appClass.AppUrl) == "string", "appClass.AppUrl must be a string")
    assert(type(appClass.AppIcon) == "string", "appClass.AppIcon must be a string")
    assert(type(appClass.AppAuthor) == "string", "appClass.AppAuthor must be a string")
    appClass.AppAuthorUrl = appClass.AppAuthorUrl or ""
    assert(type(appClass.AppAuthorUrl) == "string", "appClass.AppAuthorUrl must be a string")
    appClass.IsPaySoftware = appClass.IsPaySoftware or false
    assert(type(appClass.IsPaySoftware) == "boolean", "appClass.IsPaySoftware must be a boolean")
    appClass.AppPrice = appClass.AppPrice or 0.0
    if appClass.IsPaySoftware then
        assert(type(appClass.AppPrice) == "number", "appClass.AppPrice must be a number")
    end
    assert(type(appClass.IsUploadToGooglePlay) == "boolean", "appClass.IsUploadToGooglePlay must be a boolean")
    assert(type(appClass.IsUploadToAppStore) == "boolean", "appClass.IsUploadToAppStore must be a boolean")
    assert(type(appClass.AppSize) == "number", "appClass.AppSize must be a number")
    appClass.onAppOpen = appClass.onAppOpen or function() end
    assert(type(appClass.onAppOpen) == "function" or type(appClass.onAppOpen) == "table", "appClass.onAppOpen must be a function")
    appClass.onAppClose = appClass.onAppClose or function() end
    assert(type(appClass.onAppClose) == "function" or type(appClass.onAppClose) == "table", "appClass.onAppClose must be a function")
    appClass.onAppInstall = appClass.onAppInstall or function() end
    assert(type(appClass.onAppInstall) == "function" or type(appClass.onAppInstall) == "table", "appClass.onAppInstall must be a function")
    appClass.onAppUninstall = appClass.onAppUninstall or function() end
    assert(type(appClass.onAppUninstall) == "function" or type(appClass.onAppUninstall) == "table", "appClass.onAppUninstall must be a function")
    --#endregion
    appList[appClass.AppPackageName] = appClass
    table.insert(appIndex, appClass.AppPackageName)
end)


appModule = {
    ---get app via package name
    ---@param packageName string package name
    ---@return App app
    GetApp = function(packageName)
        assert(type(packageName) == "string", "package name must be string")
        if appList[packageName] then
            return appList[packageName]
        end
        error("package name:".. packageName .." not found")
        return nil
    end,
    ---get app via app index
    ---@param index integer
    ---@return App|nil
    GetAppViaAppIndex = function(index)
        assert(type(index) == "number", "appIndex must be number")
        if appIndex[index] then
            if appIndex[index] then
                return appList[appIndex[index]]
            end
            error("package name:" .. appIndex[index] .. " not found")
            return nil
        end
        error ("index of app: "..index.." not found")
        return nil
    end,
    ---get app index
    ---@param packageName string package name
    ---@return integer index of the app
    GetAppIndex = function(packageName)
        assert(type(packageName) == "string", "package name must be string")
        for k, v in pairs(appIndex) do
            if v == packageName then
                return k
            end
        end
        error("package name:".. packageName .." not found")
        return nil
    end,
    ---get all app in list
    ---@return table<string,App>
    GetApps = function()
        return appList
    end,
    ---get all app index
    ---@return table<integer,string>
    GetAppsIndex = function()
        return appIndex
    end,
    IsAppExists = function(packageName)
        assert(type(packageName) == "string", "package name must be string")
        if appList[packageName] then
            return true
        end
        return false
    end,
}

TriggerEvent("RegisterModule", "App", appModule, true) --暴露模块