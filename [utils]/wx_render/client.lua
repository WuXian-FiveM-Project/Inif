TriggerEvent("RegisterModule","Render",
{
    Marker = {
        ---draw marker
        ---@param options table 
        ---{
        ---  type --[[integer:required]]]],
        ---  positionX --[[number:required]],
        ---  positionY --[[number:required]],
        ---  positionZ --[[number:required]],
        ---  rotationX --[[number]],
        ---  rotationY --[[number]],
        ---  rotationZ --[[number]],
        ---  scaleX --[[number:required]],
        ---  scaleY --[[number:required]],
        ---  scaleZ --[[number:required]],
        ---  colorR --[[number:required]],
        ---  colorG --[[number:required]],
        ---  colorB --[[number:required]],
        ---  alpha --[[number]],
        ---  jitterUpAndDown --[[boolean]],
        ---  faceToCamera --[[boolean]],
        ---  spin --[[boolean]],
        ---  onEnter --[[function]]
        ---}
        DrawMarker = function(options)
            --#region error handler
        assert(options.type,"type is required")
        assert(type(options.type)=="number","type must be a number")
        options.type = math.floor(options.type)
        assert(options.positionX,"positionX is required")
        assert(type(options.positionX)=="number","positionX must be a number")
        assert(options.positionY,"positionY is required")
        assert(type(options.positionY)=="number","positionY must be a number")
        assert(options.positionZ,"positionZ is required")
        assert(type(options.positionZ)=="number","positionZ must be a number")
        options.positionX = options.positionX+0.001
        options.positionY = options.positionY+0.001
        options.positionZ = options.positionZ+0.001
        options.rotationX = options.rotationX or 0
        options.rotationY = options.rotationY or 0
        options.rotationZ = options.rotationZ or 0
        options.rotationX = options.rotationX +0.001
        options.rotationY = options.rotationY +0.001
        options.rotationZ = options.rotationZ +0.001
        assert(type(options.rotationX)=="number","rotationX must be a number")
        assert(type(options.rotationY)=="number","rotationY must be a number")
        assert(type(options.rotationZ)=="number","rotationZ must be a number")
        options.scaleX = options.scaleX+0.001 or 1
        options.scaleY = options.scaleY+0.001 or 1
        options.scaleZ = options.scaleZ+0.001 or 1
        assert(type(options.scaleX)=="number","scaleX must be a number")
        assert(type(options.scaleY)=="number","scaleY must be a number")
        assert(type(options.scaleZ)=="number","scaleZ must be a number")
        assert(options.colorR,"colorR is required")
        assert(type(options.colorR)=="number","colorR must be a number")
        assert(options.colorG,"colorG is required")
        assert(type(options.colorG)=="number","colorG must be a number")
        assert(options.colorB,"colorB is required")
        assert(type(options.colorB)=="number","colorB must be a number")
        options.alpha = options.alpha or 255
        options.jitterUpAndDown = options.jitterUpAndDown or false
        options.faceToCamera = options.faceToCamera or false
        --#endregion
            if IsSphereVisible(options.positionX,options.positionY,options.positionZ, 1.0 --[[ number ]]) then --究极抠门优化
                DrawMarker(
                    options.type,
                    options.positionX,
                    options.positionY,
                    options.positionZ,
                    0.0,
                    0.0,
                    0.0,
                    options.rotationX,
                    options.rotationY,
                    options.rotationZ,
                    options.scaleX,
                    options.scaleY,
                    options.scaleZ,
                    options.colorR,
                    options.colorG,
                    options.colorB,
                    options.alpha,
                    options.jitterUpAndDown,
                    options.faceToCamera,
                    2,
                    options.spin or false,
                    nil,
                    nil,
                    false
                )
                if Vdist2(GetEntityCoords(GetPlayerPed(-1)),vec3(options.positionX,options.positionY,options.positionZ)) < math.max(options.scaleX,options.scaleY,options.scaleZ) then
                    if options.onEnter then
                        options.onEnter()
                    end
                end
            end
        end,
        ---draw marker but with class can control parameters in realtime
        ---@param options table 
        ---{
        ---  type --[[integer:required]]]],
        ---  positionX --[[number:required]],
        ---  positionY --[[number:required]],
        ---  positionZ --[[number:required]],
        ---  rotationX --[[number]],
        ---  rotationY --[[number]],
        ---  rotationZ --[[number]],
        ---  scaleX --[[number:required]],
        ---  scaleY --[[number:required]],
        ---  scaleZ --[[number:required]],
        ---  colorR --[[number:required]],
        ---  colorG --[[number:required]],
        ---  colorB --[[number:required]],
        ---  alpha --[[number]],
        ---  jitterUpAndDown --[[boolean]],
        ---  faceToCamera --[[boolean]],
        ---  onEnter --[[function]],
        ---  spin --[[boolean]],
        ---}
        DrawMarkerWithClass = function(options)
            --#region error handler
        assert(options.type,"type is required")
        assert(type(options.type)=="number","type must be a number")
        options.type = math.floor(options.type)
        assert(options.positionX,"positionX is required")
        assert(type(options.positionX)=="number","positionX must be a number")
        assert(options.positionY,"positionY is required")
        assert(type(options.positionY)=="number","positionY must be a number")
        assert(options.positionZ,"positionZ is required")
        assert(type(options.positionZ)=="number","positionZ must be a number")
        options.positionX = options.positionX+0.001
        options.positionY = options.positionY+0.001
        options.positionZ = options.positionZ+0.001
        options.rotationX = options.rotationX or 0
        options.rotationY = options.rotationY or 0
        options.rotationZ = options.rotationZ or 0
        options.rotationX = options.rotationX +0.001
        options.rotationY = options.rotationY +0.001
        options.rotationZ = options.rotationZ +0.001
        assert(type(options.rotationX)=="number","rotationX must be a number")
        assert(type(options.rotationY)=="number","rotationY must be a number")
        assert(type(options.rotationZ)=="number","rotationZ must be a number")
        options.scaleX = options.scaleX+0.001 or 1
        options.scaleY = options.scaleY+0.001 or 1
        options.scaleZ = options.scaleZ+0.001 or 1
        assert(type(options.scaleX)=="number","scaleX must be a number")
        assert(type(options.scaleY)=="number","scaleY must be a number")
        assert(type(options.scaleZ)=="number","scaleZ must be a number")
        assert(options.colorR,"colorR is required")
        assert(type(options.colorR)=="number","colorR must be a number")
        assert(options.colorG,"colorG is required")
        assert(type(options.colorG)=="number","colorG must be a number")
        assert(options.colorB,"colorB is required")
        assert(type(options.colorB)=="number","colorB must be a number")
        options.alpha = options.alpha or 255
        options.jitterUpAndDown = options.jitterUpAndDown or false
        options.faceToCamera = options.faceToCamera or false
        --#endregion
            local self = {}
            self.type = options.type
            self.positionX = options.positionX
            self.positionY = options.positionY
            self.positionZ = options.positionZ
            self.rotationX = options.rotationX
            self.rotationY = options.rotationY
            self.rotationZ = options.rotationZ
            self.scaleX = options.scaleX
            self.scaleY = options.scaleY
            self.scaleZ = options.scaleZ
            self.colorR = options.colorR
            self.colorG = options.colorG
            self.colorB = options.colorB
            self.alpha = options.alpha
            self.jitterUpAndDown = options.jitterUpAndDown
            self.faceToCamera = options.faceToCamera
            self.spin = options.spin or false
            self.isDrawing = false
        
            ---draw 1 frame only
            self.Draw = function()
                if IsSphereVisible(options.positionX,options.positionY,options.positionZ, 1.0 --[[ number ]]) then --究极抠门优化
                    DrawMarker(
                        self.type,
                        self.positionX,
                        self.positionY,
                        self.positionZ,
                        0.0,
                        0.0,
                        0.0,
                        self.rotationX,
                        self.rotationY,
                        self.rotationZ,
                        self.scaleX,
                        self.scaleY,
                        self.scaleZ,
                        self.colorR,
                        self.colorG,
                        self.colorB,
                        self.alpha,
                        self.jitterUpAndDown,
                        self.faceToCamera,
                        2,
                        true,
                        nil,
                        nil,
                        self.spin
                    )
                end
            end
            self.StartDraw = function()
                self.isDrawing = true
                Citizen.CreateThread(function()
                    while self.isDrawing do
                        Citizen.Wait(0)
                        self:Draw()
                        if Vdist2(GetEntityCoords(GetPlayerPed(-1)),self.positionX,self.positionY,self.positionZ)<self.scaleY then
                            if options.onEnter then
                                options.onEnter()
                            end
                        end
                    end
                end)
            end
            self.StopDraw = function()
                self.isDrawing = false
            end
            self.Kill = function()
                self = nil
            end
            self.Destroy = self.Kill
        
            self.Update = function(newParameters)
                newParameters = json.decode(json.encode(newParameters))
                for k, v in pairs(newParameters) do
                    print(k,v)
                    if type(v) == "number" then
                        v = v+0.001
                    end
                    self[k] = v
                end
            end
        
            return self
        end
    },
    Light = {
        ---draw light
        ---@param options table
        ---{
        ---     positionX --[[ number ]],
        ---	    positionY --[[ number ]],
        ---	    positionZ --[[ number ]],
        ---	    colorR --[[ integer ]],
        ---	    colorG --[[ integer ]],
        ---	    colorB --[[ integer ]],
        ---	    range --[[ number ]],
        ---     intensity --[[ number ]],
        ---}
        DrawLight = function(options)
            --#region error handler
            assert(options.positionX,"positionX is required")
            assert(type(options.positionX)=="number","positionX must be a number")
            assert(options.positionY,"positionY is required")
            assert(type(options.positionY)=="number","positionY must be a number")
            assert(options.positionZ,"positionZ is required")
            assert(type(options.positionZ)=="number","positionZ must be a number")
            options.positionX = options.positionX+0.001
            options.positionY = options.positionY+0.001
            options.positionZ = options.positionZ+0.001
            assert(options.colorR,"colorR is required")
            assert(type(options.colorR)=="number","colorR must be a number")
            assert(options.colorG,"colorG is required")
            assert(type(options.colorG)=="number","colorG must be a number")
            assert(options.colorB,"colorB is required")
            assert(type(options.colorB)=="number","colorB must be a number")
            assert(options.range,"range is required")
            assert(type(options.range)=="number","range must be a number")
            assert(options.intensity,"intensity must be a number")
            assert(type(options.intensity)=="number","intensity must be a number")
            --#endregion
            DrawLightWithRangeAndShadow(
            	options.positionX --[[ number ]],
            	options.positionY --[[ number ]],
            	options.positionZ --[[ number ]],
            	options.colorR --[[ integer ]],
            	options.colorG --[[ integer ]],
            	options.colorB --[[ integer ]],
            	options.range --[[ number ]],
                options.intensity --[[ number ]],
                1.0
            )
        end,
        ---draw light
        ---@param options table
        ---{
        ---     positionX --[[ number ]],
        ---	    positionY --[[ number ]],
        ---	    positionZ --[[ number ]],
        ---	    colorR --[[ integer ]],
        ---	    colorG --[[ integer ]],
        ---	    colorB --[[ integer ]],
        ---	    range --[[ number ]],
        ---     intensity --[[ number ]],
        ---}
        DrawLightWithClass = function(options)
            --#region error handler
            assert(options.positionX,"positionX is required")
            assert(type(options.positionX)=="number","positionX must be a number")
            assert(options.positionY,"positionY is required")
            assert(type(options.positionY)=="number","positionY must be a number")
            assert(options.positionZ,"positionZ is required")
            assert(type(options.positionZ)=="number","positionZ must be a number")
            options.positionX = options.positionX+0.001
            options.positionY = options.positionY+0.001
            options.positionZ = options.positionZ+0.001
            assert(options.colorR,"colorR is required")
            assert(type(options.colorR)=="number","colorR must be a number")
            assert(options.colorG,"colorG is required")
            assert(type(options.colorG)=="number","colorG must be a number")
            assert(options.colorB,"colorB is required")
            assert(type(options.colorB)=="number","colorB must be a number")
            assert(options.range,"range is required")
            assert(type(options.range)=="number","range must be a number")
            assert(options.intensity,"intensity must be a number")
            assert(type(options.intensity)=="number","intensity must be a number")
            --#endregion
            local self = {}
            self.positionX = options.positionX
            self.positionY = options.positionY
            self.positionZ = options.positionZ
            self.colorR = options.colorR
            self.colorG = options.colorG
            self.colorB = options.colorB
            self.range = options.range
            self.intensity = options.intensity
            self.isDrawing = false
            self.Draw = function()
                DrawLightWithRangeAndShadow(
                    self.positionX,
                    self.positionY,
                    self.positionZ,
                    self.colorR,
                    self.colorG,
                    self.colorB,
                    self.range,
                    self.intensity,
                    1.0
                )
            end
            self.StartDraw = function()
                self.isDrawing = true
                Citizen.CreateThread(function()
                    while self.isDrawing do
                        Citizen.Wait(0)
                        self.Draw()
                    end
                end)
            end
            self.StopDraw = function()
                self.isDrawing = false
            end
            self.Kill = function()
                self = nil
            end
            self.Destroy = self.Kill
            
            self.Update = function(newParameters)
                newParameters = json.decode(json.encode(newParameters))
                for k, v in pairs(newParameters) do
                    if type(v) == "number" then
                        k = tostring(k)
                        if k ~= "colorR" and k ~= "colorG" and k ~= "colorB" then
                            v = v+0.001
                        end
                    end
                    self[k] = v
                end
            end
            return self
        end,
        DrawSpotLight = function(options)
            --#region error handler
            assert(options.positionX,"positionX is required")
            assert(type(options.positionX)=="number","positionX must be a number")
            assert(options.positionY,"positionY is required")
            assert(type(options.positionY)=="number","positionY must be a number")
            assert(options.positionZ,"positionZ is required")
            assert(type(options.positionZ)=="number","positionZ must be a number")
            assert(options.aimmingCoordX,"aimmingCoordX is required")
            assert(type(options.aimmingCoordX)=="number","aimmingCoordX must be a number")
            assert(options.aimmingCoordY,"aimmingCoordY is required")
            assert(type(options.aimmingCoordY)=="number","aimmingCoordY must be a number")
            assert(options.aimmingCoordZ,"aimmingCoordZ is required")
            assert(type(options.aimmingCoordZ)=="number","aimmingCoordZ must be a number")
            assert(options.colorR,"colorR is required")
            assert(type(options.colorR)=="number","colorR must be a number")
            assert(options.colorG,"colorG is required")
            assert(type(options.colorG)=="number","colorG must be a number")
            assert(options.colorB,"colorB is required")
            assert(type(options.colorB)=="number","colorB must be a number")
            assert(options.distance,"distance is required")
            assert(type(options.distance)=="number","distance must be a number")
            assert(options.brightness,"brightness is required")
            assert(type(options.brightness)=="number","brightness must be a number")
            assert(options.roundness ,"roundness  is required")
            assert(type(options.roundness )=="number","roundness  must be a number")
            assert(options.radius,"radius is required")
            assert(type(options.radius)=="number","radius must be a number")
            assert(options.falloff,"falloff is required")
            assert(type(options.falloff)=="number","falloff must be a number")
            options.colorR = math.floor(options.colorR)
            options.colorG = math.floor(options.colorG)
            options.colorB = math.floor(options.colorB)
            --#endregion
            local startPosition = vec3(options.positionX+0.0,options.positionY+0.0,options.positionZ+0.0)
            local endPosition = vec3(options.aimmingCoordX+0.0,options.aimmingCoordY+0.0,options.aimmingCoordZ+0.0)
            local rot = startPosition-endPosition
            rot = -rot
            -- print(rot)
            DrawSpotLightWithShadow(
	            options.positionX+0.01 --[[ number ]],
	            options.positionY+0.01 --[[ number ]],
	            options.positionZ+0.01 --[[ number ]],
	            rot.x --[[ number ]],
	            rot.y --[[ number ]],
	            rot.z --[[ number ]],
	            options.colorR --[[ integer ]],
	            options.colorG --[[ integer ]],
	            options.colorB --[[ integer ]],
	            options.distance+0.01 --[[ number ]],
	            options.brightness+0.01 --[[ number ]],
	            options.roundness+0.01 --[[ number ]],
	            options.radius+0.01 --[[ number ]],
	            options.falloff+0.01 --[[ number ]],
                2
            )

        end,
        DrawSpotLightWithClass = function(options)
            --#region error handler
            assert(options.positionX,"positionX is required")
            assert(type(options.positionX)=="number","positionX must be a number")
            assert(options.positionY,"positionY is required")
            assert(type(options.positionY)=="number","positionY must be a number")
            assert(options.positionZ,"positionZ is required")
            assert(type(options.positionZ)=="number","positionZ must be a number")
            assert(options.aimmingCoordX,"aimmingCoordX is required")
            assert(type(options.aimmingCoordX)=="number","aimmingCoordX must be a number")
            assert(options.aimmingCoordY,"aimmingCoordY is required")
            assert(type(options.aimmingCoordY)=="number","aimmingCoordY must be a number")
            assert(options.aimmingCoordZ,"aimmingCoordZ is required")
            assert(type(options.aimmingCoordZ)=="number","aimmingCoordZ must be a number")
            assert(options.colorR,"colorR is required")
            assert(type(options.colorR)=="number","colorR must be a number")
            assert(options.colorG,"colorG is required")
            assert(type(options.colorG)=="number","colorG must be a number")
            assert(options.colorB,"colorB is required")
            assert(type(options.colorB)=="number","colorB must be a number")
            assert(options.distance,"distance is required")
            assert(type(options.distance)=="number","distance must be a number")
            assert(options.brightness,"brightness is required")
            assert(type(options.brightness)=="number","brightness must be a number")
            assert(options.roundness ,"roundness  is required")
            assert(type(options.roundness )=="number","roundness  must be a number")
            assert(options.radius,"radius is required")
            assert(type(options.radius)=="number","radius must be a number")
            assert(options.falloff,"falloff is required")
            assert(type(options.falloff)=="number","falloff must be a number")
            options.colorR = math.floor(options.colorR)
            options.colorG = math.floor(options.colorG)
            options.colorB = math.floor(options.colorB)
            --#endregion
            local startPosition = vec3(options.positionX+0.0,options.positionY+0.0,options.positionZ+0.0)
            local endPosition = vec3(options.aimmingCoordX+0.0,options.aimmingCoordY+0.0,options.aimmingCoordZ+0.0)
            local rot = startPosition-endPosition
            rot = -rot

            local self = {}
            self.positionX = options.positionX
            self.positionY = options.positionY
            self.positionZ = options.positionZ
            self.aimmingCoordX = options.aimmingCoordX
            self.aimmingCoordY = options.aimmingCoordY
            self.aimmingCoordZ = options.aimmingCoordZ
            self.colorR = options.colorR
            self.colorG = options.colorG
            self.colorB = options.colorB
            self.distance = options.distance
            self.brightness = options.brightness
            self.roundness = options.roundness
            self.radius = options.radius
            self.falloff = options.falloff
            self.rot = rot
            self.isDrawing = false

            self.Draw = function()
                startPosition = vec3(self.positionX+0.0,self.positionY+0.0,self.positionZ+0.0)
                endPosition = vec3(self.aimmingCoordX+0.0,self.aimmingCoordY+0.0,self.aimmingCoordZ+0.0)
                self.rot = -(startPosition-endPosition)
                DrawSpotLightWithShadow(
	                self.positionX+0.0 --[[ number ]],
	                self.positionY+0.0 --[[ number ]],
	                self.positionZ+0.0 --[[ number ]],
	                self.rot.x --[[ number ]],
	                self.rot.y --[[ number ]],
	                self.rot.z --[[ number ]],
	                self.colorR --[[ integer ]],
	                self.colorG --[[ integer ]],
	                self.colorB --[[ integer ]],
	                self.distance+0.0 --[[ number ]],
	                self.brightness+0.0 --[[ number ]],
	                self.roundness+0.0 --[[ number ]],
	                self.radius+0.0 --[[ number ]],
	                self.falloff+0.0 --[[ number ]],
                    2
                )
            end

            self.StartDraw = function()
                self.isDrawing = true
                Citizen.CreateThread(function()
                    while self.isDrawing do
                        Citizen.Wait(0)
                        self.Draw()
                    end
                end)
            end

            self.StopDraw = function()
                self.isDrawing = false
            end

            self.Kill = function()
                self = nil
            end
            self.Destroy = self.Kill
            
            self.Update = function(newParameters)
                newParameters = json.decode(json.encode(newParameters))
                for k, v in pairs(newParameters) do
                    if type(v) == "number" then
                        k = tostring(k)
                        if k ~= "colorR" and k ~= "colorG" and k ~= "colorB" then
                            v = v+0.001
                        end
                    end
                    self[k] = v
                end
            end

            return self
        end
    },
},true)