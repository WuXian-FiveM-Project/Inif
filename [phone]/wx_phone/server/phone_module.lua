local MySql = exports.wx_module_system:RequestModule("MySql")

---@class Phone
phoneModule = {
    GetPhone = function(pid)
        if MySql.Sync.Query("SELECT PID FROM player_phone WHERE PID = ?", {
            pid
        })[1] == nil then
            error("phone with pid :" .. pid .. " not found")
            return nil
        end

        local self = {}

        self.PID = {
            Get = function()
                return pid
            end
        }

        self.PhonePassword = {
            Get = function()
                return MySql.Sync.Query("SELECT PhonePassword FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhonePassword
            end,
            Set = function(newPassword)
                MySql.Sync.Query("UPDATE player_phone SET PhonePassword = ? WHERE PID = ?", {
                    newPassword,
                    self.PID.Get()
                })
            end
        }

        self.PhoneModule = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneModule FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneModule
            end,
            Set = function(newModule)
                MySql.Sync.Query("UPDATE player_phone SET PhoneModule = ? WHERE PID = ?", {
                    newModule,
                    self.PID.Get()
                })
            end
        }

        self.PhoneSetting = {
            Get = function()
                return json.decode(MySql.Sync.Query("SELECT PhoneSetting FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneSetting)
            end,
            Set = function(newSetting)
                assert(type(newSetting) == "table", "newSetting must be table")
                MySql.Sync.Query("UPDATE player_phone SET PhoneSetting = ? WHERE PID = ?", {
                    json.encode(newSetting),
                    self.PID.Get()
                })
            end,
            Add = function(key, value)
                assert(type(key) == "string", "key must be string")
                assert(type(value) == "string", "value must be string")
                local setting = self.PhoneSetting.Get()
                setting[key] = value
                self.PhoneSetting.Set(setting)
            end,
            Delete = function(key)
                assert(type(key) == "string", "key must be string")
                local setting = self.PhoneSetting.Get()
                setting[key] = nil
                self.PhoneSetting.Set(setting)
            end,
            Change = function(key, value)
                assert(type(key) == "string", "key must be string")
                assert(type(value) == "string", "value must be string")
                local setting = self.PhoneSetting.Get()
                setting[key] = value
                self.PhoneSetting.Set(setting)
            end
        }

        self.PhoneApps = {
            Get = function()
                return json.decode(MySql.Sync.Query("SELECT PhoneApps FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneApps)
            end,
            Set = function(newApps)
                assert(type(newApps) == "table", "newApps must be table")
                MySql.Sync.Query("UPDATE player_phone SET PhoneApps = ? WHERE PID = ?", {
                    json.encode(newApps),
                    self.PID.Get()
                })
            end,
            Add = function(appPackageName)
                assert(type(appPackageName) == "string", "appPackageName must be string")
                if appModule.IsAppExists(appPackageName) then
                    local appData = appModule.GetApp(appPackageName)
                    if appData.AppSize + self.PhoneCurrentCapacity.Get() <= self.PhoneMaxCapacity.Get() then
                        local apps = self.PhoneApps.Get()
                        table.insert(apps, appPackageName)
                        self.PhoneApps.Set(apps)
                        self.PhoneCurrentCapacity.Add(appData.AppSize)
                        appData.onAppInstall(self.PID.Get())
                    end
                    return false, "SpaceNotEnough"
                end
                error("app: " .. appPackageName.." not found")
            end,
            Delete = function(appPackageName)
                assert(type(appPackageName) == "string", "appPackageName must be string")
                local apps = self.PhoneApps.Get()
                for i, v in ipairs(apps) do
                    if v == appPackageName then
                        table.remove(apps, i)
                        appModule.GetApp(appPackageName).onAppUninstall(self.PID.Get())
                        break
                    end
                end
                self.PhoneApps.Set(apps)
                local appData = appModule.GetApp(appPackageName)
                self.PhoneCurrentCapacity.Remove(appData.AppSize)
            end,
        }

        self.PhoneData = {
            Get = function()
                return json.decode(MySql.Sync.Query("SELECT PhoneData FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneData)
            end,
            Set = function(newData)
                assert(type(newData) == "table", "newData must be table")
                MySql.Sync.Query("UPDATE player_phone SET PhoneData = ? WHERE PID = ?", {
                    json.encode(newData),
                    self.PID.Get()
                })
            end,
            Add = function(key, value)
                assert(type(key) == "string", "key must be string")
                assert(type(value) == "string", "value must be string")
                local data = self.PhoneData.Get()
                data[key] = value
                self.PhoneData.Set(data)
            end,
            Delete = function(key)
                assert(type(key) == "string", "key must be string")
                local data = self.PhoneData.Get()
                data[key] = nil
                self.PhoneData.Set(data)
            end,
        }

        self.PhoneRegisterDate = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneRegisterDate FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneRegisterDate
            end,
        }

        self.PhoneMaxCapacity = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneMaxCapacity FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneMaxCapacity
            end,
            Set = function(newMaxCapacity)
                assert(type(newMaxCapacity) == "number", "newMaxCapacity must be number")
                MySql.Sync.Query("UPDATE player_phone SET PhoneMaxCapacity = ? WHERE PID = ?", {
                    newMaxCapacity,
                    self.PID.Get()
                })
            end
        }

        self.PhoneCurrentCapacity = {
            Get = function()
                return MySql.Sync.Query("SELECT PhoneCurrentCapacity FROM player_phone WHERE PID = ?", {
                    self.PID.Get()
                })[1].PhoneCurrentCapacity
            end,
            Set = function(newCurrentCapacity)
                assert(type(newCurrentCapacity) == "number", "newCurrentCapacity must be number")
                MySql.Sync.Query("UPDATE player_phone SET PhoneCurrentCapacity = ? WHERE PID = ?", {
                    newCurrentCapacity,
                    self.PID.Get()
                })
            end,
            Add = function(amount)
                assert(type(amount) == "number", "amount must be number")
                local currentCapacity = self.PhoneCurrentCapacity.Get()
                currentCapacity = currentCapacity + amount
                self.PhoneCurrentCapacity.Set(currentCapacity)
            end,
            Remove = function(amount)
                assert(type(amount) == "number", "amount must be number")
                local currentCapacity = self.PhoneCurrentCapacity.Get()
                currentCapacity = currentCapacity - amount
                self.PhoneCurrentCapacity.Set(currentCapacity)
            end
        }

        return self
    end
}

TriggerEvent("RegisterModule", "Phone", phoneModule, true) --暴露模块
