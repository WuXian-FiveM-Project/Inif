
-- Citizen.CreateThread(function()
--     -- ShowAdvancedNotification(2,"wdk2wad","twdwd2witle","edwddw",2,2)
--     -- ShowAdvancedNotification(3,"wkwad","twdwd2witle","edwddw",2,2)
--     print("wd")
--     local a = true
--     Citizen.CreateThread(function()
--         Wait(1000)
--         a = false
--     end)
--     while a do
--         ShowHelpNotification("ts1et",true)
--         Wait(0)
--         print("1")
--         -- ShowFloatingHelpNotification("dwadaw",b)
--     end
--     --ShowNotification("msg")
-- end)


---show notification
---@param msg string|integer|number message to show
ShowNotification = function (msg)
    msg = tostring(msg)
    AddTextEntry('ShowNotificationString', msg)
    BeginTextCommandThefeedPost("ShowNotificationString")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(true, true)
end
---show message box with image
---@param mugshot_playerid string|integer player id
---@param sender_name string name of sender
---@param title string title of message box
---@param content string content of message box
---@param iconType integer 1=Chat Box,2=Email,3=Add Friend Request,7=Right Jumping Arrow,8=RP Icon,9=$ Icon
---@param hudColor integer https://docs.fivem.net/docs/game-references/hud-colors/
ShowAdvancedNotification = function (mugshot_playerid,sender_name,title,content,iconType,hudColor)
    mugshot_playerid = GetPlayerFromServerId(mugshot_playerid)
	AddTextEntry("AdvancedNotificationString", content)
	BeginTextCommandThefeedPost("AdvancedNotificationString")
    local textureDict  = RegisterPedheadshot(GetPlayerPed(mugshot_playerid))
    while not IsPedheadshotReady(textureDict) do
		Wait(0)
	end
    local textureId = GetPedheadshotTxdString(textureDict)
    ThefeedNextPostBackgroundColor(hudColor)
	EndTextCommandThefeedPostMessagetext(textureId, textureId, false,iconType,sender_name,title)
	EndTextCommandThefeedPostTicker(true,true)
    UnregisterPedheadshot(textureId)
end
---show help message
---@param message string|integer|number message to show
---@param beep boolean beep or not
ShowHelpNotification = function (message, beep)
    --BUG: 在被wx_garage_system调用时有几率无法显示
    AddTextEntry('HelpNotificationString', message)
	BeginTextCommandDisplayHelp("HelpNotificationString")
    EndTextCommandDisplayHelp(0, false, beep, 1 or 5000)
end
---show 3d help messsage
---@param message string|integer|number message to show
---@param coords vector3 position to show (3d coords)
ShowFloatingHelpNotification = function (message, coords)
	AddTextEntry('FloatingHelpNotificationString', message)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('FloatingHelpNotificationString')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

---show freemode message
---@param title string|integer|number title of message
---@param msg string|integer|number message to show
---@param duration integer|number time to show in ms
ShowFreemodeMessage = function(title, msg, duration)
	local scaleform = RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
	BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	PushScaleformMovieMethodParameterString(title)
	PushScaleformMovieMethodParameterString(msg)
	EndScaleformMovieMethod()
    local control = true
    Citizen.SetTimeout(duration,function()
        control = not control
    end)
	while control do
        Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end
	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

---show news bar on bottom
---@param title string|integer|number title of news
---@param message string|integer|number message to show
---@param bottomtext string|integer|number bottom text
---@param duration integer|number time to show in ms
ShowBreakingNews = function(title, message, bottomtext, duration)
	local scaleform = RequestScaleformMovie('BREAKING_NEWS')

    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end

	BeginScaleformMovieMethod(scaleform, 'SET_TEXT')
	PushScaleformMovieMethodParameterString(message)
	PushScaleformMovieMethodParameterString(bottomtext)
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleform, 'SET_SCROLL_TEXT')
	PushScaleformMovieMethodParameterInt(0) -- top ticker
	PushScaleformMovieMethodParameterInt(0) -- Since this is the first string, start at 0
	PushScaleformMovieMethodParameterString(title)

	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleform, 'DISPLAY_SCROLL_TEXT')
	PushScaleformMovieMethodParameterInt(0) -- Top ticker
	PushScaleformMovieMethodParameterInt(0) -- Index of string

	EndScaleformMovieMethod()
    local control = true

    Citizen.SetTimeout(duration, function()
        control = not control
    end)

	while control do
        Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 0, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

---show pop up message such as GTA OL ban message
---@param title string|integer|number title of message
---@param message string|integer|number message to show
---@param bottomtext string|integer|number bottom text
---@param duration integer|number time to show in ms
ShowPopupWarning = function(title, message, bottomtext, duration)
	local scaleform = RequestScaleformMovie('POPUP_WARNING')

    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end

	BeginScaleformMovieMethod(scaleform, 'SHOW_POPUP_WARNING')

	PushScaleformMovieMethodParameterFloat(500.0) -- black background
	PushScaleformMovieMethodParameterString(title)
	PushScaleformMovieMethodParameterString(message)
	PushScaleformMovieMethodParameterString(bottomtext)
	PushScaleformMovieMethodParameterBool(true)

	EndScaleformMovieMethod()
    local control = true

    Citizen.SetTimeout(duration, function()
        control = not control
    end)

	while control do
        Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

ShowGlassNotification = function(title, message, bottomText, duration)
    SendNUIMessage({
        type = "ShowGlassNotification",
        title = title,
        message = message,
        bottomText = bottomText,
        duration = duration,
    })
end

TriggerEvent("RegisterModule","Notification",{
    ---show notification
    ---@param msg string|integer|number message to show
    ShowNotification = ShowNotification,
    ---show message box with image
    ---@param mugshot_playerid string|integer player id
    ---@param sender_name string name of sender
    ---@param title string title of message box
    ---@param content string content of message box
    ---@param iconType integer 1=Chat Box,2=Email,3=Add Friend Request,7=Right Jumping Arrow,8=RP Icon,9=$ Icon
    ---@param hudColor integer https://docs.fivem.net/docs/game-references/hud-colors/
    ShowAdvancedNotification = ShowAdvancedNotification,
    ---show help message
    ---@param message string|integer|number message to show
    ---@param beep boolean beep or not
    ShowHelpNotification = ShowHelpNotification,
    ---show 3d help messsage
    ---@param message string|integer|number message to show
    ---@param coords vector3 position to show (3d coords)
    ShowFloatingHelpNotification = ShowFloatingHelpNotification,
    ---show freemode message
    ---@param title string|integer|number title of message
    ---@param message string|integer|number message to show
    ---@param duration integer|number time to show in ms
    ShowFreemodeMessage = ShowFreemodeMessage,
    ---show news bar on bottom
    ---@param title string|integer|number title of news
    ---@param message string|integer|number message to show
    ---@param bottomtext string|integer|number bottom text
    ---@param duration integer|number time to show in ms
    ShowBreakingNews = ShowBreakingNews,
    ---show pop up message such as GTA OL ban message
    ---@param title string|integer|number title of message
    ---@param message string|integer|number message to show
    ---@param bottomtext string|integer|number bottom text
    ---@param duration integer|number time to show in ms
    ShowPopupWarning = ShowPopupWarning,
},true)

RegisterNetEvent('wx_player_notify:ShowNotification',function(message)
    ShowNotification(message)
end)
RegisterNetEvent('wx_player_notify:ShowAdvancedNotification',function(mugshot_playerid,sender_name,title,message,iconType,hudColor)
    ShowAdvancedNotification(mugshot_playerid,sender_name,title,message,iconType,hudColor)
end)
RegisterNetEvent('wx_player_notify:ShowHelpNotification',function(message, beep,duration)
    local control = true
    Citizen.SetTimeout(duration,function()
        control = not control
    end)
    while control do
        Wait(0)
        ShowHelpNotification(message, beep)
    end
end)
RegisterNetEvent('wx_player_notify:ShowFreemodeMessage',function(title, message,duration)
    ShowFreemodeMessage(title, message,duration)
end)
RegisterNetEvent('wx_player_notify:ShowBreakingNews',function(title, message,bottomtext,duration)
    ShowBreakingNews(title, message,bottomtext,duration)
end)
RegisterNetEvent('wx_player_notify:ShowPopupWarning',function(title, message,bottomtext,duration)
    ShowPopupWarning(title, message,bottomtext,duration)
end)
RegisterNetEvent('wx_player_notify:ShowFloatingHelpNotification',function(message,coords,duration)
    local control = true
    Citizen.SetTimeout(duration, function()
        control = not control
    end)
    while control do
        Wait(0)
        ShowFloatingHelpNotification(message,coords)
    end
end)

--TODO:3d scaleform 演示 WIP!!!
-- Citizen.CreateThread(function()
--     Wait(02000)
--     local scaleform = RequestScaleformMovie('BREAKING_NEWS')

--     while not HasScaleformMovieLoaded(scaleform) do
--         Wait(0)
--     end
--     local pc = GetEntityCoords(PlayerPedId())
-- 	BeginScaleformMovieMethod(scaleform, 'SET_TEXT')
-- 	PushScaleformMovieMethodParameterString("3d !!!")
-- 	PushScaleformMovieMethodParameterString("卧槽 浮在空中了")
-- 	EndScaleformMovieMethod()

-- 	BeginScaleformMovieMethod(scaleform, 'SET_SCROLL_TEXT')
-- 	PushScaleformMovieMethodParameterInt(0) -- top ticker
-- 	PushScaleformMovieMethodParameterInt(0) -- Since this is the first string, start at 0
-- 	PushScaleformMovieMethodParameterString("牛逼")

-- 	EndScaleformMovieMethod()

-- 	BeginScaleformMovieMethod(scaleform, 'DISPLAY_SCROLL_TEXT')
-- 	PushScaleformMovieMethodParameterInt(0) -- Top ticker
-- 	PushScaleformMovieMethodParameterInt(0) -- Index of string

-- 	EndScaleformMovieMethod()


--     while true do
--         Wait(0)
--         DrawScaleformMovie_3dSolid(
--             scaleform --[[ integer ]], 
--             pc.x --[[ number ]], 
--             pc.y --[[ number ]], 
--             pc.z+1 --[[ number ]], 
--             0.0 --[[ number ]], 
--             0.0 --[[ number ]], 
--             0.0 --[[ number ]], 
--             0.0 --[[ number ]], 
--             100.0 --[[sharpness   number ]], 
--             0.0 --[[ number ]], 
--             1.5 --[[ number ]], 
--             1.5 --[[ number ]], 
--             1.5 --[[ number ]], 
--             false --[[ Any ]]
--         )
--     end
-- end)