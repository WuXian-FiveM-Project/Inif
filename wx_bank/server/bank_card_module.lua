local MySql = exports.wx_module_system:RequestModule("MySql")
TriggerEvent("RegisterModule", "BankCard", {
    ---get bank card class
    ---@param CardID string CardID
    ---@return boolean | table "true表示成功，false表示失败，table表示成功，返回一个class"
    GetBankCardViaCardID = function(CardID)
        assert(type(CardID) == "string", "CardID must be string")
        local tempCardData = MySql.Sync.Query("SELECT * FROM bank_account WHERE CardID = ?", {
            CardID
        })[1]
        if tempCardData.BID == nil then
            return false
        end
        local self = {}

        self.BID = {
            Get = function()
                return tempCardData.BID
            end
        }
        self.CardID = {
            Get = function()
                return tempCardData.CardID
            end
        }
        self.CardOwnerSteamID = {
            Get = function()
                return MySql.Sync.Query("SELECT CardOwnerSteamID FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardOwnerSteamID
            end,
            Set = function(SteamID)
                assert(type(SteamID) == "string", "SteamID must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardOwnerSteamID = ? WHERE BID = ?", {
                    SteamID,
                    self.BID.Get()
                })
            end
        }
        self.CardHolderFirstName = {
            Get = function()
                return MySql.Sync.Query("SELECT CardHolderFirstName FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardHolderFirstName
            end,
            Set = function(Name)
                assert(type(Name) == "string", "Name must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardHolderFirstName = ? WHERE BID = ?", {
                    Name,
                    self.BID.Get()
                })
            end
        }
        self.CardHolderSecondName = {
            Get = function()
                return MySql.Sync.Query("SELECT CardHolderSecondName FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardHolderSecondName
            end,
            Set = function(Name)
                assert(type(Name) == "string", "Name must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardHolderSecondName = ? WHERE BID = ?", {
                    Name,
                    self.BID.Get()
                })
            end
        }
        self.CardHolderTelephoneNumber = {
            Get = function()
                return MySql.Sync.Query("SELECT CardHolderTelephoneNumber FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardHolderTelephoneNumber
            end,
            Set = function(Number)
                assert(type(Number) == "string", "Number must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardHolderTelephoneNumber = ? WHERE BID = ?", {
                    Number,
                    self.BID.Get()
                })
            end
        }
        self.CardPassword = {
            Get = function()
                return MySql.Sync.Query("SELECT CardPassword FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardPassword
            end,
            Set = function(Password)
                assert(type(Password) == "string", "Password must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardPassword = ? WHERE BID = ?", {
                    Password,
                    self.BID.Get()
                })
            end
        }
        self.CardExpiryDate = {
            Get = function()
                return MySql.Sync.Query("SELECT CardExpiryDate FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardExpiryDate
            end,
            Set = function(Date)
                assert(type(Date) == "string", "Date must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardExpiryDate = ? WHERE BID = ?", {
                    Date,
                    self.BID.Get()
                })
            end
        }
        self.CardRegisterDate = {
            Get = function()
                return MySql.Sync.Query("SELECT CardRegisterDate FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardRegisterDate
            end,
            Set = function(Date)
                assert(type(Date) == "string", "Date must be string")
                MySql.Sync.Query("UPDATE bank_account SET CardRegisterDate = ? WHERE BID = ?", {
                    Date,
                    self.BID.Get()
                })
            end
        }
        self.CardBalance = {
            Get = function()
                return MySql.Sync.Query("SELECT CardBalance FROM bank_account WHERE BID = ?", {
                    self.BID.Get()
                })[1].CardBalance
            end,
            Set = function(Balance)
                assert(type(Balance) == "number", "Balance must be number")
                MySql.Sync.Query("UPDATE bank_account SET CardBalance = ? WHERE BID = ?", {
                    Balance,
                    self.BID.Get()
                })
            end,
            Add = function(Balance)
                assert(type(Balance) == "number", "Balance must be number")
                MySql.Sync.Query("UPDATE bank_account SET CardBalance = CardBalance + ? WHERE BID = ?", {
                    Balance,
                    self.BID.Get()
                })
            end,
            ---remove Balance from bank account
            ---@param Balance number Balance to add
            ---@param isForce boolean | nil isForce force remove Balance whatever it is less than 0
            ---@return boolean success success or not
            Remove = function(Balance, isForce)
                assert(type(Balance) == "number", "Balance must be number")
                isForce = isForce or false
                assert(type(isForce) == "boolean", "isForce must be boolean")
                if isForce then
                    MySql.Sync.Query("UPDATE bank_account SET CardBalance = CardBalance - ? WHERE BID = ?", {
                        Balance,
                        self.BID.Get()
                    })
                    return true
                else
                    if self.CardBalance.Get() >= Balance then
                        MySql.Sync.Query("UPDATE bank_account SET CardBalance = CardBalance - ? WHERE BID = ?", {
                            Balance,
                            self.BID.Get()
                        })
                        return true
                    else
                        return false
                    end
                end
            end
        }
        self.ItemName = self.BID.Get().."_bank_card"
        self.GetItemName = function()
            return self.ItemName
        end
        return self
    end,
    GetBankCardViaBID = function(BID)
        local cardID = MySql.Sync.Query("SELECT CardID FROM bank_account WHERE BID = ?", {
            BID
        })[1].CardID
        return exports.wx_module_system:RequestModule("BankCard").GetBankCardViaCardID(cardID)
    end
},true)