local MySql = exports.wx_module_system:RequestModule("MySql")
TriggerEvent("RegisterPlayerModule","LastPosition", function(self) --self 是隐式参数 self = Player.GetPlayer()
    self.LastPosition = {}
    ---@class vector3
    
    ---get player last saved position
    ---@return vector3 | boolean state if valid position return vec3 else return false
    self.LastPosition.Get = function()
        local result = MySql.Sync.Query("SELECT LastPosition FROM player WHERE SteamID = ?",{
            self.SteamID.Get()
        })
        if result and result[1] then
            result = json.decode(result[1].LastPosition)
            return vec3(result.x,result.y,result.z)
        end
        return false
    end

    ---set last saved position
    ---@param vector3 vector3 | table struct of {x,y,z}
    ---@param ... number
    self.LastPosition.Set = function(vector3,...)
        if type(vector3) == "table" or type(vector3) == "vector3" then
            MySql.Sync.Query("UPDATE player SET LastPosition = ? WHERE SteamID = ?",{
                json.encode(vector3),
                self.SteamID.Get()
            })
        elseif #{...} == 2 then
            local tempParms = {...}
            local tempVec3 = vec3(vector3,tempParms[2],tempParms[3])
            MySql.Sync.Query("UPDATE player SET LastPosition = ? WHERE SteamID = ?",{
                json.encode(tempVec3),
                self.SteamID.Get()
            })
        end
    end

    return self
end)