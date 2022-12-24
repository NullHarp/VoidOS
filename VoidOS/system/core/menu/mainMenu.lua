local menuAPI = require("/VoidOS/system/core/api/menu")
local util = require("/VoidOS/system/core/api/util")

local menu = {
    "Programs",
    "Tools   ",
    "Shell   "
}
local menuRun = {
    "/VoidOS/system/core/menu/programMenu",
    "",
    "bg shell"
}
util.title("Main Menu")
menuAPI.createMenu(menu,menuRun,1,4)