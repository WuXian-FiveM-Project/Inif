TriggerEvent("RegisterModule","Console",{
    Log = function (string,toconsole)
        if toconsole then
            print("[ConsoleLog]："..string)
        end
        SaveResourceFile(
            GetCurrentResourceName() --[[ string ]],
	        "Log.txt" --[[ string ]],
	        LoadResourceFile(GetCurrentResourceName() --[[ string ]], "Log.txt" --[[ string ]]).."\n["..os.date('%Y年%m月%d日 %H时%M分%S秒').."][ConsoleLog]："..string --[[ string ]],
	        -1 --[[ integer ]]
	    )
    end,
    Warning = function (string,toconsole)
        if toconsole then
            print("^3[ConsoleWarning]："..string.."")
        end
        SaveResourceFile(
            GetCurrentResourceName() --[[ string ]],
	        "Log.txt" --[[ string ]],
	        LoadResourceFile(GetCurrentResourceName() --[[ string ]], "Log.txt" --[[ string ]]).."\n["..os.date('%Y年%m月%d日 %H时%M分%S秒').."][ConsoleWarning]："..string --[[ string ]],
	        -1 --[[ integer ]]
	    )
    end,
    Error = function (string,toconsole)
        if toconsole then
            error("^1[ConsoleError]："..string)
        end
        SaveResourceFile(
            GetCurrentResourceName() --[[ string ]],
	        "Log.txt" --[[ string ]],
	        LoadResourceFile(GetCurrentResourceName() --[[ string ]], "Log.txt" --[[ string ]]).."\n["..os.date('%Y年%m月%d日 %H时%M分%S秒').."][ConsoleError]："..string --[[ string ]],
	        -1 --[[ integer ]]
	    )
    end,
    Test = function (string)
        print("^4[ConsoleTest]："..string)
        SaveResourceFile(
            GetCurrentResourceName() --[[ string ]],
	        "Log.txt" --[[ string ]],
	        LoadResourceFile(GetCurrentResourceName() --[[ string ]], "Log.txt" --[[ string ]]).."\n["..os.date('%Y年%m月%d日 %H时%M分%S秒').."][ConsoleTest]："..string --[[ string ]],
	        -1 --[[ integer ]]
	    )
    end
},true)