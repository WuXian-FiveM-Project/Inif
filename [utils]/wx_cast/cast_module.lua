TriggerEvent("RegisterModule","Cast",{
    ---cast to string
    ---@param sourceData string|table|number|boolean|integer
    ---@return string result cast result
    castToString = function(sourceData)
        if type(sourceData) == "string" then
            return sourceData
        elseif type(sourceData) == "table" then
            return json.encode(sourceData)
        elseif type(sourceData) == "number" then
            return tostring(sourceData)
        elseif type(sourceData) == "boolean" then
            return tostring(sourceData)
        elseif type(sourceData) == "integer" then
            return tostring(sourceData)
        else
            return tostring(sourceData)
        end
    end,
    ---cast data to boolean
    ---@param sourceData string|number|boolean|integer
    ---@return boolean result cast result
    castToBoolean = function(sourceData)
        if type(sourceData) == "boolean" then
            return sourceData
        elseif type(sourceData) == "string" then
            return sourceData == "true"
        elseif type(sourceData) == "number" then
            return sourceData ~= 0
        elseif type(sourceData) == "integer" then
            return sourceData ~= 0
        else
            return false
        end
    end,
    ---cast to number
    ---@param sourceData string|number|boolean|integer
    ---@return number result cast result
    castToNumber = function(sourceData)
        if type(sourceData) == "number" then
            return sourceData+0.0
        elseif type(sourceData) == "integer" then
            return sourceData+0.0
        elseif type(sourceData) == "string" then
            local matchString = ""
            for i = 1, #sourceData do
                if tonumber(sourceData:sub(i, i)) or sourceData:sub(i, i) == "." then
                    matchString = matchString .. sourceData:sub(i,i)
                end
            end
            return tonumber(matchString) + 0.0
        elseif type(sourceData) == "boolean" then
            return sourceData and 1.0 or 0.0
        else
            return 0.0
        end
    end,
    ---cast to integer
    ---@param sourceData string|number|boolean|integer
    ---@return integer result cast result
    castToInteger = function(sourceData)
        sourceData = exports.wx_module_system:RequestModule("Cast").castToNumber(sourceData)
        return math.floor(sourceData + 0.5)
    end,
},true)