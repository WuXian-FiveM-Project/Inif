MySql = exports.wx_module_system:RequestModule("MySql")

TriggerEvent("RegisterPlayerModule","Bank",function(self) --self 是隐式参数 self = Player.GetPlayer()
    self.Bank = {}

    ---get player all bank cards
    ---@return table table return format: {[1] = "Card number",[2] = "tow card number",...}
    self.Bank.GetAllCards = function()
        return MySql.Fatch("player_bank",{"CardID"},{{Method = "AND",Column = "SteamID",Value = self.SteamID.Get(),Operator = "="}})
    end

    self.Bank.Card = {}

    return self
end)