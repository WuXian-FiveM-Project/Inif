TriggerEvent("RegisterPlayerModule","Coords",function(self) --self 是隐式参数 self = Player.GetPlayer()
    self.Coords = {}
    ---get player Coords
    ---@return vector3 position coords
    self.Coords.Get = function()
        return GetEntityCoords(GetPlayerPed(self.source))
    end
    ---set player Coords
    ---@param x number|integer coords x
    ---@param y number|integer coords y
    ---@param z number|integer coords z
    self.Coords.Set = function(x,y,z)
        x,y,z = x+0.0,y+0.0,z+0.0
        SetEntityCoords(GetPlayerPed(self.source),x,y,z,true,true,true,false)
    end
    return self
end)

TriggerEvent("RegisterPlayerModule","Rotation",function(self) --self 是隐式参数 self = Player.GetPlayer()
    self.Rotation = {}
    ---get player Rotation
    ---@return vector3 rotation
    self.Rotation.Get = function()
        return GetEntityRotation(GetPlayerPed(self.source))
    end
    ---set player Rotation
    ---@param pitch number|integer rotation pitch
    ---@param roll number|integer rotation roll
    ---@param yaw number|integer rotation yaw
    self.Rotation.Set = function(pitch ,roll ,yaw )
        pitch ,roll ,yaw = pitch+0.0,roll+0.0,yaw+0.0
        SetEntityRotation(GetPlayerPed(self.source),pitch ,roll ,yaw ,1 ,true)
    end
    return self
end)