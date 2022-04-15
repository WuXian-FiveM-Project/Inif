--#region class define

---@class Source : number
---@class Entity : number
---@class Ped : Entity
---@class Vehicle : number
---@class SteamIdentifier : string
---@class LicenseIdentifier : string
---@class DiscordIdentifier : string
---@class IP : string

---@class vector2
---@field x number x coordinate
---@field y number y coordinate
vector2 = {
    x = 0.0, --A floating point number representing the x value of your vector.
    y = 0.0, --A floating point number representing the y value of your vector.
}

---@class vector3
---@field x number x coordinate
---@field y number y coordinate
---@field z number z coordinate
vector3 = {
    x = 0.0, --A floating point number representing the x value of your vector.
    y = 0.0, --A floating point number representing the y value of your vector.
    z = 0.0, --A floating point number representing the z value of your vector.
}

---@class vector4
---@field x number x coordinate
---@field y number y coordinate
---@field z number z coordinate
---@field w number w coordinate
vector4 = {
    x = 0.0, --A floating point number representing the x value of your vector.
    y = 0.0, --A floating point number representing the y value of your vector.
    z = 0.0, --A floating point number representing the z value of your vector.
    w = 0.0, --A floating point number representing the w value of your vector.
}

---@class quat
---@field w number w coordinate
---@field x number x coordinate
---@field y number y coordinate
---@field z number z coordinate
quat = {
    w = 0.0, --A floating point number representing the w value of your quaternion.
    x = 0.0, --A floating point number representing the x value of your quaternion.
    y = 0.0, --A floating point number representing the y value of your quaternion.
    z = 0.0, --A floating point number representing the z value of your quaternion.
}

---@class model : string

---@class Item
---@field ItemName string item name
---@field ItemShowName string item show name
---@field ItemType string item type
---@field ItemDescription string item description
---@field ItemDensity number item density
---@field ItemModel model item model
---@field ItemMaxDensity number item max density
---@field ItemMaxUseAmount number item max use amount
---@field ItemMaxThrowAmount number item max throw amount
---@field ItemMaxTransferAmount number item max transfer amount
---@field ItemImage string item image
---@field ItemMaxAmount string item max amount
---@field ItemMaxStack number item max stack
---@field CanItemDrop boolean can item drop
---@field CanItemPickup boolean can item pickup
---@field CanItemUse boolean can item use
---@field CanItemTransfer boolean can item transfer
---@field CanItemCombine boolean can item combine
---@field IsItemPhysicalAfterDrop boolean is item physical after drop
---@field UseFunction function use function
---@field DropFunction function drop function
---@field PickupFunction function pickup function
---@field StackFunction function stack function
---@field TransferFunction function transfer function
---@field IsEnableAntiCheat boolean is enable anti cheat
Item = {
    ItemName                = "",
    ItemShowName            = "",
    ItemType                = "",
    ItemDescription         = "",
    ItemDensity             = 0.0,
    ItemModel               = "",
    ItemMaxDensity          = 0.0,
    ItemMaxUseAmount        = 0, --[[物品单次最大使用数]]
    ItemMaxThrowAmount      = 0, --[[物品单次最大丢弃数]]
    ItemMaxTransferAmount   = 0, --[[物品单次最大转移数]]
    ItemImage               = "", --[[支持base64  基于html src ]]
    ItemMaxAmount           = 0,
    ItemMaxStack            = 0,
    CanItemDrop             = false,
    CanItemPickup           = false,
    CanItemUse              = false,
    CanItemTransfer         = false,
    CanItemCombine          = false,
    IsItemPhysicalAfterDrop = false,
    UseFunction             = function() end,
    DropFunction            = function() end,
    PickupFunction          = function() end,
    StackFunction           = function() end,
    TransferFunction        = function() end,
    IsEnableAntiCheat       = false,
}

---@class InventoryItem : Item
---@field Amount integer amount
---@field Density number density
---@field ItemAmount integer max ItemAmount
---@field AttachData table attach data
---@field ID integer IID
---@field IID integer IID

---@class Module : table

--#endregion
