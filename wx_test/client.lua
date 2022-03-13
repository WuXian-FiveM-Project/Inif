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
