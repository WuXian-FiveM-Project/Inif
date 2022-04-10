local MySql = exports.wx_module_system:RequestModule("MySql")
local PhoneApp = exports.wx_module_system:RequestModule("PhoneApp")

TriggerEvent('RegisterModule',"Phone",{
    ---get phone class
    ---@param PID number | string pid of phone
    ---@return table Phone phone class
    GetPhone = function(PID)
        assert(type(PID) == "number" or type(PID) == "string","PID must be a number or string")
        if type(PID) == "string" then
            local PPID = PID
            PID = tonumber(PID)
            assert(type(PID) == "number","fail to cast PID to number, cast value:" .. PPID)
        end
        local self = {}
        self.__index = self

        self.Pid = {
            Get = function()
                return PID
            end,
        }

        self.PhonePassword = {
            Get = function()
                return MySql.Sync.Query("SELECT PhonePassword FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhonePassword
            end,
            Set = function(value)
                assert(type(value) == "string" or type(value) == "number","PhonePassword must be a string or number")
                value = tostring(value)
                MySql.Sync.Query("UPDATE player_phone SET PhonePassword = ? WHERE PID = ?",{
                    value,
                    self.Pid.Get()
                })
            end,
        }

        self.PhoneModule = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneModule FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhoneModule
            end,
            Set = function(value)
                assert(type(value) == "string","PhoneModule must be a string")
                MySql.Sync.Query("UPDATE player_phone SET PhoneModule = ? WHERE PID = ?",{
                    value,
                    self.Pid.Get()
                })
            end,
        }

        self.PhoneSetting = {
            Get = function()
                return json.decode(MySql.Sync.Query("SELECT PhoneSetting FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhoneSetting)
            end,
            Set = function(value)
                assert(type(value) == "table","PhoneSetting must be a table")
                MySql.Sync.Query("UPDATE player_phone SET PhoneSetting = ? WHERE PID = ?",{
                    json.encode(value),
                    self.Pid.Get()
                })
            end,
        }

        self.PhoneApps = {
            Get = function()
                return json.decode(MySql.Sync.Query("SELECT PhoneApps FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhoneApps)
            end,
            Set = function(value)
                assert(type(value) == "table","PhoneApps must be a table")
                MySql.Sync.Query("UPDATE player_phone SET PhoneApps = ? WHERE PID = ?",{
                    json.encode(value),
                    self.Pid.Get()
                })
            end,
            Add = function(appPackageName)
                assert(type(appPackageName) == "table", "value must be a table")
                local app = PhoneApp.GetAppByPackageName("value")
                if self.PhoneCurrentCapacity.Get() + app.size > self.PhoneMaxCapacity.Get() then
                    return nil
                end
                if app then
                    local prePhoneApps = self.PhoneApps.Get()
                    prePhoneApps[#prePhoneApps+1] = {
                        packageName          = app.packageName,
                        displayName          = app.displayName,
                        icon                 = app.icon,
                        overwrite            = app.overwrite,
                        url                  = app.url,
                        version              = app.version,
                        author               = app.author,
                        authorUrl            = app.authorUrl,
                        description          = app.description,
                        isSystemApp          = app.isSystemApp,
                        isUploadToAppStore   = app.isUploadToAppStore,
                        isUploadToGooglePlay = app.isUploadToGooglePlay,
                        isPaySoftware        = app.isPaySoftware,
                        price                = app.price,
                        size                 = app.size,
                    }
                    self.PhoneApps.Set(prePhoneApps)
                    MySql.Sync.Query("UPDATE player_phone SET PhoneCurrentCapacity = ? WHERE PID = ?", {
                        self.PhoneCurrentCapacity.Get() + app.size,
                        self.Pid.Get()
                    })
                end
                return nil
            end,
            Install = function(appPackageName) self.PhoneApps.Add(appPackageName) end,
            Uninstall = function(appPackageName)
                local prePhoneApps = self.PhoneApps.Get()
                for i,v in ipairs(prePhoneApps) do
                    if v.packageName == appPackageName then
                        table.remove(prePhoneApps,i)
                        break
                    end
                end
                self.PhoneApps.Set(prePhoneApps)
            end,
            Remove = function(appPackageName) self.PhoneApps.Uninstall(appPackageName) end,
        }

        self.PhoneRegisterDate = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneRegisterDate FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhoneRegisterDate
            end,
            Set = function(value)
                assert(type(value) == "number","PhoneRegisterDate must be a number")
                MySql.Sync.Query("UPDATE player_phone SET PhoneRegisterDate = ? WHERE PID = ?",{
                    value,
                    self.Pid.Get()
                })
            end,
        }

        self.PhoneMaxCapacity = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneMaxCapacity FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhoneMaxCapacity
            end,
            Set = function(value)
                assert(type(value) == "number","PhoneMaxCapacity must be a number")
                MySql.Sync.Query("UPDATE player_phone SET PhoneMaxCapacity = ? WHERE PID = ?",{
                    value,
                    self.Pid.Get()
                })
            end,
        }

        self.PhoneCurrentCapacity = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneCurrentCapacity FROM player_phone WHERE PID = ?",{
                    self.Pid.Get()
                })[1].PhoneCurrentCapacity
            end,
            Set = function(value)
                assert(type(value) == "number","PhoneCurrentCapacity must be a number")
                MySql.Sync.Query("UPDATE player_phone SET PhoneCurrentCapacity = ? WHERE PID = ?",{
                    value,
                    self.Pid.Get()
                })
            end,
        }

        return self
    end,
    ---register phone
    ---@param PhonePassword string | number phone password
    ---@param PhoneModule string phone module
    ---@param PhoneSetting table phone setting
    ---@param PhoneApps table phone apps
    ---@param PhoneMaxCapacity number phone max capacity(kb)
    RegisterPhone = function(PhonePassword,PhoneModule,PhoneSetting,PhoneApps,PhoneMaxCapacity)
        assert(type(PhonePassword) == "string" or type(PhonePassword) == "number","PhonePassword must be a string or number")
        PhonePassword = tostring(PhonePassword)
        assert(type(PhoneModule) == "string","PhoneModule must be a string")
        assert(type(PhoneSetting) == "table","PhoneSetting must be a table")
        assert(type(PhoneApps) == "table","PhoneApps must be a table")
        assert(type(PhoneMaxCapacity) == "number","PhoneMaxCapacity must be a number")
        MySql.Sync.Query("INSERT INTO player_phone (PhonePassword,PhoneModule,PhoneSetting,PhoneApps,PhoneMaxCapacity,PhoneCurrentCapacity) VALUES (?,?,?,?,?,?)",{
            PhonePassword,
            PhoneModule,
            json.encode(PhoneSetting),
            json.encode(PhoneApps),
            PhoneMaxCapacity,
            1
        })
        local Pid = MySql.Sync.Query("SELECT PID FROM player_phone WHERE PhonePassword = ? AND PhoneModule = ? AND PhoneSetting = ? AND PhoneApps = ? AND PhoneMaxCapacity = ?",{
            PhonePassword,
            PhoneModule,
            json.encode(PhoneSetting),
            json.encode(PhoneApps),
            PhoneMaxCapacity
        })[1].PID
        local phone = exports.wx_module_system:RequestModule("Phone").GetPhone(Pid)
        assert(type(phone) == "table","fail to get phone, but register success")
        TriggerEvent("RegisterItem", {
            ItemName = Pid.."_phone",
            ItemShowName = "手机",
            ItemType = "工具",
            ItemDescription = "行动电话，又称手提式电话机或手提电话，简称手机",
            ItemDensity = 100,
            ItemModel = "prop_phone_proto",
            ItemMaxDensity = 50000000000,
            ItemMaxAmount = 1,
            ItemMaxUseAmount = 1,
            ItemMaxTransferAmount = 1,
            ItemMaxThrowAmount = 1,
            ItemMaxStack = 1,
            ItemImage = "https://www.apple.com/v/iphone-13-pro/f/images/overview/design/finishes_1_alpine_green__bxgqurawflau_large.jpg",
            CanItemDrop = true,
            CanItemPickup = true,
            CanItemUse = true,
            CanItemTransfer = true,
            CanItemCombine = true,
            IsItemPhysicalAfterDrop = true,
            UseFunction = function(PlayerID,ItemAmount,AttachData,Reject)
                Reject()
                local phoneData = MySql.Sync.Query("SELECT * FROM player_phone WHERE PID = ?",{
                    Pid
                })[1]
                phoneData.PhoneSetting = json.decode(phoneData.PhoneSetting)
                phoneData.PhoneApps = json.decode(phoneData.PhoneApps)
                TriggerClientEvent("wx_phone:usePhone",PlayerID,phoneData)
            end,
            DropFunction = nil,
            PickupFunction = nil,
            StackFunction = nil,
            TransferFunction = nil,
            IsEnableAntiCheat = true,
        })
        return phone
    end
},true)