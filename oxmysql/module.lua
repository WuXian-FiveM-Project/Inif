local Console = exports.wx_module_system:RequestModule("Console")
TriggerEvent("RegisterModule","MySql",{
	Sync = {
		---insert data to some table
		---@param Table string table you want to insert
		---@param Data table the data you want to insert such as {Column = "PID" , Value = "12121"}
		---@return any
		Insert = function (Table,Data)
			--Row format {Column = "PID" , Value = "12121"}
			local args = ""
			local instandtext = ""
			local value = {}
			for _,i in ipairs(Data) do
				args = args..i.Column..","
				instandtext = instandtext.."?,"
				table.insert(value,i.Value)
			end
			args = string.sub(args, 1, -2)
			instandtext = string.sub(instandtext, 1, -2)
			Console.Log(("Sql insert into \""..Table.."\" query: ".."INSERT INTO "..Table.." ("..args..") VALUES ("..instandtext..") ".."["..json.encode(value).."]"),Config.LogToConsole)
			return exports.oxmysql:insert_async("INSERT INTO "..Table.." ("..args..") VALUES ("..instandtext..") ", value)
		end,
		---fetch data from table
		---@param Table string table you want to insert
		---@param FetchRows table|string if you want to fetch all then field "*" else do this {"the","column","you","want","to","fetch"}
		---@param MatchRule table|nil eg:{Method = "OR"|"AND" , Column = "PID" , Value = "2121131" , Operator = "<"|">"|"="}
		---@return any
		Fetch = function (Table,FetchRows,MatchRule)
			--FetchRows format {"PID","SID","Name"}
			assert(type(Table) == "string" ,"Table must be string")
			assert(type(FetchRows) == "string" or type(FetchRows) == "table","FetchRows must be table or \"*\"")
			assert(type(MatchRule) == "table" or type(MatchRule) == "nil" ,"MatchRule must be table or nil")
			local fetchrule = ""
			if FetchRows ~= "*" then
				for _, v in ipairs(FetchRows) do
					fetchrule = fetchrule..v..","
				end
				fetchrule = string.sub(fetchrule, 1, -2)
			else
				fetchrule = "*"
			end
			--MatchRule format
			--{
			--	{Method = "OR"|"AND" , Column = "IQ" , Value = "10" , Operator = "<"|">"|"="},
			--	{Method = "OR"|"AND" , Column = "PID" , Value = "2121131" , Operator = "<"|">"|"="}
			--}
			local matchrule = ""
			local matchstd = {}
			if type(MatchRule) ~= "nil" then
				matchrule = " WHERE "
				local position = 1
				for _, v in ipairs(MatchRule) do
					if position == 1 then
						matchrule = matchrule..v.Column..v.Operator.."?,"
						position = position + 1
					else
						matchrule = string.sub(matchrule, 1, -2) .. " "
						matchrule = matchrule..v.Method.." "..v.Column..v.Operator.."?,"
					end
					table.insert(matchstd,v.Value)
				end
				matchrule = string.sub(matchrule, 1, -2)
			end
			Console.Log(("Sql fetch \""..Table.."\" query: ".."SELECT "..fetchrule.." FROM "..Table.. matchrule.." List：["..json.encode(matchstd).."]"),Config.LogToConsole)
			return exports.oxmysql:query_async("SELECT "..fetchrule.." FROM "..Table.. matchrule,matchstd)
		end,
		---delete data from table
		---@param Table string table you want to insert
		---@param MatchRule table|nil if you want to delete all data in table then field "*" else eg:{Method = "OR"|"AND" , Column = "PID" , Value = "2121131" , Operator = "<"|">"|"="}
		---@return table result the sql return's result
		Delete = function (Table,MatchRule)
			--MatchRule format {Method = "OR"|"AND" , Column = "PID" , Value = "2121131" , Operator = "<"|">"|"="}
			assert(type(Table) == "string","Table must be string")
			assert(type(MatchRule) == "table" or type(MatchRule) == "nil" ,"MatchRule must be table or nil")
			local matchrule = ""
			local matchstd = {}
			if type(MatchRule) ~= "nil" then
				matchrule = " WHERE "
				local position = 1
				for _, v in ipairs(MatchRule) do
					if position == 1 then
						matchrule = matchrule..v.Column..v.Operator.."?,"
						position = position + 1
					else
						matchrule = string.sub(matchrule, 1, -2) .. " "
						matchrule = matchrule..v.Method.." "..v.Column..v.Operator.."?,"
					end
					table.insert(matchstd,v.Value)
				end
				matchrule = string.sub(matchrule, 1, -2)
			end
			Console.Log(("Sql delete \""..Table.."\" query: "..'DELETE FROM '..Table.." "..matchrule.."["..json.encode(matchstd).."]"),Config.LogToConsole)
			return exports.oxmysql:query_async('DELETE FROM '..Table.." "..matchrule, matchstd)
		end,
		---update data to table
		---@param Table string table you want to insert
		---@param UpdateValue table table the data you want to update such as {Column = "Name" , Value = "dddaw"}
		---@param MatchRule table|nil if you want to update all data in table then field "*" else eg:{Method = "OR"|"AND" , Column = "PID" , Value = 1 , Operator = "<"|">"|"="}
		---@return integer effectrows effect rows
		Update = function (Table,UpdateValue,MatchRule)
			assert(type(Table) == "string","Table must be string")
			assert(type(UpdateValue) == "table","UpdateValue must be table")
			assert(type(MatchRule) == "table" or type(MatchRule) == "nil" ,"MatchRule must be table or nil")
			local std_merge = {}
			--UpdateValue format {Column = "PID" , Value = "12121"}
			local updatevalue = ""
			for _,v in pairs(UpdateValue) do 
				updatevalue = updatevalue .. v.Column .. "= ?,"
				table.insert(std_merge,v.Value)
			end
			updatevalue = string.sub(updatevalue, 1, -2)
			--MatchRule format {Column = "PID" , Value = "12121"}
			local matchrule = ""
			if type(MatchRule) ~= "nil" then
				matchrule = " WHERE "
				local position = 1
				for _, v in ipairs(MatchRule) do
					if position == 1 then
						matchrule = matchrule..v.Column..v.Operator.."?,"
						position = position + 1
					else
						matchrule = string.sub(matchrule, 1, -2) .. " "
						matchrule = matchrule..v.Method.." "..v.Column..v.Operator.."?,"
					end
					table.insert(std_merge,v.Value)
				end
				matchrule = string.sub(matchrule, 1, -2)
			end
			Console.Log(("Sql update \""..Table.."\" query: ".."UPDATE "..Table.." SET "..updatevalue.." "..matchrule.."["..json.encode(std_merge).."]"),Config.LogToConsole)
			return exports.oxmysql:update_async("UPDATE "..Table.." SET "..updatevalue.." "..matchrule, std_merge)
		end
	}
},true)
