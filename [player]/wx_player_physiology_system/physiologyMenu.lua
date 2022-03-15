RegisterCommand('+openPhsiologyMenu', function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        type = "openPhsiologyMenu"
    })
end)
RegisterCommand('-openPhsiologyMenu', function()end)

RegisterNUICallback('closePhsiologyMenu', function(data,cb)
    SetNuiFocus(false,false)
end)
RegisterNUICallback('goPee', function(data,cb)
    SetNuiFocus(false,false)
    TriggerEvent("doPee")
end)

RegisterNUICallback('goShit', function(data,cb)
    SetNuiFocus(false,false)
    TriggerEvent("doShit")
end)
RegisterKeyMapping('+openPhsiologyMenu', '打开生理系统菜单', 'keyboard', 'o')


AddEventHandler('doShit',function()
    local animDict = "amb@lo_res_idles@"
    local animName = "lying_face_down_lo_res_base"
    RequestAnimDict(animDict --[[ string ]])
    RequestAnimSet(animName --[[ string ]])
    RequestAnimDict(animDict --[[ string ]])
    RequestAnimSet(animName --[[ string ]])
    ClearPedTasks(GetPlayerPed(-1))
    local shouldCreateShit = true
    FreezeEntityPosition(GetPlayerPed(-1),true)
    Citizen.CreateThread(function()
        while shouldCreateShit do
            local p = GetEntityCoords(GetPlayerPed(-1))
            local retval --[[ boolean ]], groundZ --[[ number ]] =
            GetGroundZFor_3dCoord_2(
            	p.x --[[ number ]], 
            	p.y --[[ number ]], 
            	p.z --[[ number ]], 
            	false --[[ boolean ]]
            )
            local o = CreateObject(
                GetHashKey("prop_big_shit_01"),
                p.x+math.random()*0.1,
                p.y+math.random()*0.1,
                groundZ+math.random()*0.1,
                true,
                false,
                true
            )
            ApplyForceToEntity(
            	o --[[ Entity ]], 
            	0 --[[ integer ]], 
            	0.0001 --[[ number ]], 
            	0.0001 --[[ number ]], 
            	0.0001 --[[ number ]], 
            	0.0 --[[ number ]], 
            	0.0 --[[ number ]], 
            	0.0 --[[ number ]], 
            	0 --[[ integer ]], 
            	false --[[ boolean ]], 
            	true --[[ boolean ]], 
            	true --[[ boolean ]], 
            	false --[[ boolean ]], 
            	true --[[ boolean ]]
            )
            Wait(Utils.GenerateRandomInt(100,800))
        end
    end)
    Wait(Utils.GenerateRandomInt(5000,10000))
    shouldCreateShit = false
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerServerEvent("wx_player_physiology_system:goShit")
end)

AddEventHandler('doPee',function()
    local animDict = "missbigscore1switch_trevor_piss"
    local animName = "piss_loop"
    RequestAnimDict(animDict --[[ string ]])
    RequestAnimSet(	animName --[[ string ]])
    RequestAnimDict(animDict --[[ string ]])
    RequestAnimSet(	animName --[[ string ]])
    TaskPlayAnim(GetPlayerPed(-1), animDict,animName,8.0,8.0,-1,49,0,false,false,false)
    local Utils = exports.wx_module_system:RequestModule("Utils")
    local shouldShootParticle = true
    local particle 
    Citizen.CreateThread(function()
        while shouldShootParticle do
            -- local dict = "scr_amb_chop"
            -- local particleName = "ent_anim_dog_peeing"
            local dict = "cut_exile1"
            local particleName = "ent_amb_peeing"
            RequestNamedPtfxAsset(dict)
            while not HasNamedPtfxAssetLoaded(dict) do
                Citizen.Wait(0)
            end    
            UseParticleFxAssetNextCall(dict)
            local ped = GetPlayerPed(-1)
            local startCoords = GetEntityCoords(ped)
            particle = StartParticleFxLoopedAtCoord(
                particleName,
                startCoords.x,
                startCoords.y,
                startCoords.z-0.1,
                90.0,
                0.0,
                Utils.GetEntityHeading(ped),
                2.0, false, false, false)
            Wait(50000)
        end
    end)

    Wait(Utils.GenerateRandomInt(5000,10000))

    shouldShootParticle = false
    ClearPedTasks(GetPlayerPed(-1))
    StopParticleFxLooped(particle,false)
    TriggerServerEvent("wx_player_physiology_system:goPee")
end)