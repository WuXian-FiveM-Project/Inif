Citizen.CreateThread(function()
    local sql = exports.wx_module_system:RequestModule("sql")
    sql.Async.Query("SELECT * FROM garage_vehicle WHERE VID=?",{
        9
    },function (result)
        print(json.encode(result))
    end)
end)