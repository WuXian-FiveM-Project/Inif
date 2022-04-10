local phoneAppList = {}
local phoneAppIndex = {}

AddEventHandler("RegisterPhoneApp", function(option)
    RegisterPhoneApp(option)
end)

--- Register App Parameters
---@class App
AppParameters = {
    packageName          = "com.example.phoneapp",
    displayName          = "phoneapp",
    icon                 = "phoneapp.png",
    overwrite            = false,
    url                  = "nui://example/index.html",
    version              = "1.0.0",
    author               = "example",
    authorUrl            = "https://example.com",
    description          = "phoneapp description",
    isSystemApp          = false,
    isUploadToAppStore   = true,
    isUploadToGooglePlay = true,
    isPaySoftware        = false,
    price                = 0.0,
    size                 = 0,
    onAppOpen            = function()    end,
    onAppClose           = function()   end,
    onAppInstall         = function()   end,
    onAppUninstall       = function() end,
}
---register phone app
---@param option App phone app option
function RegisterPhoneApp(option)
    assert(type(option) == "table","option must be a table")
    assert(type(option.packageName) == "string","option.packageName must be a string")
    if phoneAppList[option.packageName] and option.overwrite == false then
        error("phone app already exist,and not overwrite enable",1)
        return
    end
    assert(type(option.displayName) == "string","option.displayName must be a string")
    assert(type(option.icon) == "string","option.icon must be a string")
    assert(type(option.overwrite) == "boolean","option.overwrite must be a boolean")
    assert(type(option.url) == "string","option.url must be a string")
    assert(type(option.version) == "string","option.version must be a string")
    assert(type(option.author) == "string","option.author must be a string")
    assert(type(option.authorUrl) == "string","option.authorUrl must be a string")
    assert(type(option.description) == "string","option.description must be a string")
    assert(type(option.isSystemApp) == "boolean","option.isSystemApp must be a boolean")
    assert(type(option.isUploadToAppStore) == "boolean","option.isUploadToAppStore must be a boolean")
    assert(type(option.isUploadToGooglePlay) == "boolean","option.isUploadToGooglePlay must be a boolean")
    assert(type(option.isPaySoftware) == "boolean","option.isPaySoftware must be a boolean")
    if option.isPaySoftware then
        assert(type(option.price) == "number","option.number must be a number")
    end

    option.overwrite            = option.overwrite or false
    option.packageName          = option.packageName or "default"
    option.displayName          = option.displayName or "default"
    option.icon                 = option.icon or "default"
    option.url                  = option.url or "default"
    option.version              = option.version or "default"
    option.author               = option.author or "default"
    option.authorUrl            = option.authorUrl or "default"
    option.description          = option.description or "default"
    option.isSystemApp          = option.isSystemApp or false
    option.isUploadToAppStore   = option.isUploadToAppStore or false
    option.isUploadToGooglePlay = option.isUploadToGooglePlay or false
    option.isPaySoftware        = option.isPaySoftware or false
    option.price                = option.price or 0.0
    option.size                 = option.size or 0

    if option.onAppOpen then
        assert(type(option.onAppOpen) == "function","option.onAppOpen must be a function")
        option.onAppOpen = option.onAppOpen or function() end
    end
    if option.onAppClose then
        assert(type(option.onAppClose) == "function","option.onAppClose must be a function")
        option.onAppClose = option.onAppClose or function() end
    end
    if option.onAppInstall then
        assert(type(option.onAppInstall) == "function","option.onAppInstall must be a function")
        option.onAppInstall = option.onAppInstall or function() end
    end
    if option.onAppUninstall then
        assert(type(option.onAppUninstall) == "function","option.onAppUninstall must be a function")
        option.onAppUninstall = option.onAppUninstall or function() end
    end
    phoneAppList[option.packageName] = option
    table.insert(phoneAppIndex,option.packageName)
end

TriggerEvent("RegisterModule","PhoneApp",{
    ---get app by package name
    ---@param packageName string package name
    ---@return App
    GetAppByPackageName = function(packageName)
        return phoneAppList[packageName]
    end,
    ---get app by index
    ---@param index number index
    ---@return App
    GetAppByIndex = function(index)
        if phoneAppIndex[index] then
            if phoneAppList[phoneAppIndex[index]] then
                return phoneAppList[phoneAppIndex[index]]
            end
            error("app package : "..phoneAppIndex[index].." not exist",1)
            return nil
        end
        error("app index : "..index.." not exist",1)
        return nil
    end,
    ---get app index list
    ---@return table<integer, string> app app index list
    GetAppPackageList = function()
        return phoneAppIndex
    end,
    ---get app package table
    ---@return table<string,App>
    GetAppPackageTable = function()
        return phoneAppList
    end,
},true)