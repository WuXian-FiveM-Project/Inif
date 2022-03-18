Citizen.CreateThread(function()
    -- If waypoint is set get directions
    local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
    local retval, direction, vehicle, distance = GenerateDirectionsToCoord(waypointCoords.x, waypointCoords.y, waypointCoords.z, 0)
    local Notification = exports.wx_module_system:RequestModule("Notification")
    local text = "n"
    while true do
        waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
        retval, direction, vehicle, distance = GenerateDirectionsToCoord(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
        Wait(0)
        if direction == 0 then
            text = "请回到路面上"
        elseif direction == 1 then
            text = "方向错误"
        elseif direction == 2 then
            text = "直行"
        elseif direction == 3 then
            text = "左转"
        elseif direction == 4 then
            text = "右转"
        elseif direction == 5 then
            text = "保持直行"
        elseif direction == 6 then
            text = "立即左转"
        elseif direction == 7 then
            text = "立即右转"
        elseif direction == 8 then
            text = "无法计算"
        end
        Notification.ShowHelpNotification(("{ %s ,  %s,  %s}"):format(direction,distance,text))
    end
end)

local cache = {}

function LoadScaleform(dui3dHandle, scaleform)
    local scaleformHandle = RequestScaleformMovie(scaleform) -- Request the scaleform

    -- Wait till it has loaded
    while not HasScaleformMovieLoaded(scaleformHandle) do
        scaleformHandle = RequestScaleformMovie(scaleform)
        Citizen.Wait(5)
    end

    -- Save the handle in the table
    cache[dui3dHandle].scaleform = scaleformHandle
end

function StartupDui(dui3dHandle, url, width, height)
    local txd = CreateRuntimeTxd('txd') -- Create texture dictionary

    cache[dui3dHandle].dui = CreateDui(url, width, height) -- Create Dui with the url

    local dui = GetDuiHandle(cache[dui3dHandle].dui) -- Getting dui handle

    CreateRuntimeTextureFromDuiHandle(txd, 'txn', dui) -- Applying the txd on the dui

    if cache[dui3dHandle].scaleform ~= nil and not cache[dui3dHandle].txd then
        PushScaleformMovieFunction(cache[dui3dHandle].scaleform, 'SET_TEXTURE')

        PushScaleformMovieMethodParameterString('txd') -- txd
        PushScaleformMovieMethodParameterString('txn') -- txn

        PushScaleformMovieFunctionParameterInt(0) -- x
        PushScaleformMovieFunctionParameterInt(0) -- y
        PushScaleformMovieFunctionParameterInt(width)
        PushScaleformMovieFunctionParameterInt(height)

        PopScaleformMovieFunctionVoid()
        cache[dui3dHandle].txd = true
    end
end

-- Native
function Create3dNui(sfName, url)
    local dui3dHandle = tostring(math.random(0, 9999))

    cache[dui3dHandle] = {
        dui = nil,
        txd = false,
        scaleform = nil,
        show = false,
        coords = nil,
        scale = nil
    }

    -- Auto load the scaleform
    LoadScaleform(dui3dHandle, sfName)

    if url ~= nil then
        StartupDui(dui3dHandle, "nui://"..GetCurrentResourceName().."/"..url, 1920, 1080)
    end


    -- Class to return
    local class3d = {}
    class3d.__index = class3d

    class3d.init = function(self, url, width, height)
        StartupDui(dui3dHandle, "nui://"..GetCurrentResourceName().."/"..url, width or 1920, height or 1080)
    end

    class3d.show = function(self, coords, scale)
        cache[dui3dHandle].coords = coords
        cache[dui3dHandle].scale = scale or 0.1
        cache[dui3dHandle].show = true
    end

    return dui3dHandle, setmetatable({}, class3d)
end

-- Main
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
    
        for k,v in pairs(cache) do
            if v.show then
                local scaleformCoords = vector3(v.coords.x - 1, v.coords.y, v.coords.z + 2)
                local  scaleformScale = vector3(v.scale*1, v.scale*(9/16), 1)
                
                if v.scaleform ~= nil and HasScaleformMovieLoaded(v.scaleform) then
                    --                             handle           coords            rot      unk        scale      unk
                    DrawScaleformMovie_3dNonAdditive(v.scaleform, scaleformCoords, 0, 0, 0, 0, 0, 0, scaleformScale, 0)
                end
            end
        end
        Citizen.Wait(5)
    end
end)


-- Snippets
local dui = nil

Citizen.CreateThread(function()
    local _, _dui = Create3dNui("generic_texture_renderer", "index.html")
    dui = _dui

    dui:show(GetEntityCoords(PlayerPedId()))
end)