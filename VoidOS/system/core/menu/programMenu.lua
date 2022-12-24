local menuAPI = require("/VoidOS/system/core/api/menu")
local util = require("/VoidOS/system/core/api/util")

local menu = {
    "Option 1",
    "Option 2",
    "Back    "
}
local menuRun = {
    "",
    "",
    "VoidOS/system/core/menu/mainMenu"
}
util.title("Programs")
menuAPI.createMenu(menu,menuRun,1,4)