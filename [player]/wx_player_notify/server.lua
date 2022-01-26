TriggerEvent("RegisterPlayerModule","Notification",function(self) --self 是隐式参数 self = Player.GetPlayer()
    self.Notification = {}
    ---show notification
    ---@param msg string|integer|number message to show
    self.Notification.ShowNotification = function(message)
        TriggerClientEvent("wx_player_notify:ShowNotification",self.PlayerID.Get(),message)
    end
    ---show message box with image
    ---@param iconplayerid string|integer player id
    ---@param sender_name string name of sender
    ---@param title string title of message box
    ---@param message string content of message box
    ---@param iconType integer 1=Chat Box,2=Email,3=Add Friend Request,7=Right Jumping Arrow,8=RP Icon,9=$ Icon
    ---@param hudColor integer https://docs.fivem.net/docs/game-references/hud-colors/
    self.Notification.ShowAdvancedNotification = function(iconplayerid,sender_name,title,message,iconType,hudColor)
        TriggerClientEvent("wx_player_notify:ShowAdvancedNotification",self.PlayerID.Get(),iconplayerid,sender_name,title,message,iconType,hudColor)
    end
    ---show help message
    ---@param message string|integer|number message to show
    ---@param beep boolean beep or not
    self.Notification.ShowHelpNotification = function (message, beep,duration)
        TriggerClientEvent('wx_player_notify:ShowHelpNotification',self.PlayerID.Get(),message,beep,duration)
    end
    self.Notification.ShowFloatingHelpNotification = function (message,coords,duration)
        TriggerClientEvent('wx_player_notify:ShowFloatingHelpNotification',self.PlayerID.Get(),message,coords,duration)
    end
    ---show freemode message
    ---@param title string|integer|number title of message
    ---@param message string|integer|number message to show
    ---@param duration integer|number time to show in ms
    self.Notification.ShowFreemodeMessage = function (title, message,duration)
        TriggerClientEvent('wx_player_notify:ShowFreemodeMessage',self.PlayerID.Get(),title,message,duration)
    end
    ---show news bar on bottom
    ---@param title string|integer|number title of news
    ---@param message string|integer|number message to show
    ---@param bottomtext string|integer|number bottom text
    ---@param duration integer|number time to show in ms
    self.Notification.ShowBreakingNews = function (title, message,bottomtext,duration)
        TriggerClientEvent('wx_player_notify:ShowBreakingNews',self.PlayerID.Get(),title,message,bottomtext,duration)
    end
    ---show pop up message such as GTA OL ban message
    ---@param title string|integer|number title of message
    ---@param message string|integer|number message to show
    ---@param bottomtext string|integer|number bottom text
    ---@param duration integer|number time to show in ms
    self.Notification.ShowPopupWarning = function (title, message,bottomtext,duration)
        TriggerClientEvent('wx_player_notify:ShowPopupWarning',self.PlayerID.Get(),title,message,bottomtext,duration)
    end
    return self
end)