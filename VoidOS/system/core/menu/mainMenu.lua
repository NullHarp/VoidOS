local menuAPI = require("/VoidOS/system/core/api/menu")

local menuStart,user = ...

local mainMenuOptions = {
    "Programs",
    "Tools   ",
    "Shell   "
}

local programsMenuOptions = {
    "Option 1",
    "Option 2",
    "Back    "
}

local toolsMenuOptions = {

    "File Explorer",
    "File Transfer",
    "New Account  ",
    "Update       ",
    "Back         "
}

local old_term = term.current()

local mainMenu = menuAPI.createMenu()
local programsMenu = menuAPI.createMenu()
local toolsMenu = menuAPI.createMenu()

local currentMenu = {}

local function menuChange(m,mTitle,mOptions)
    currentMenu.menu = m currentMenu.title = mTitle menuOptions = mOptions
end

if menuStart == nil then
    menuChange(mainMenu,"Main Menu",mainMenuOptions)
    mainMenu.setVisible(true)
else
    if menuStart == "program" then
        menuChange(programsMenu,"Programs Menu",programsMenuOptions)
        programsMenu.setVisible(true)
    elseif menuStart == "tool" then
        menuChange(toolsMenu,"Tools Menu",toolsMenuOptions)
        toolsMenu.setVisible(true)
    end
end

while true do
    local selected = menuAPI.runMenu(menuOptions,currentMenu.menu,1,4,currentMenu.title)
    if currentMenu.menu == mainMenu then
        if selected == 1 then
            mainMenu.setVisible(false)
            currentMenu.menu = programsMenu currentMenu.title = "Programs Menu" menuOptions = programsMenuOptions
            programsMenu.setVisible(true)
        elseif selected == 2 then
            mainMenu.setVisible(false)
            currentMenu.menu = toolsMenu currentMenu.title = "Tools Menu" menuOptions = toolsMenuOptions
            toolsMenu.setVisible(true)
        elseif selected == 3 then
            shell.run("bg shell")
        end
    elseif currentMenu.menu == programsMenu then
        if selected == 3 then
            programsMenu.setVisible(false)
            currentMenu.menu = mainMenu currentMenu.title = "Main Menu" menuOptions = mainMenuOptions
            mainMenu.setVisible(true)
        end
    elseif currentMenu.menu == toolsMenu then
        if selected == 1 then
            shell.run("/VoidOS/system/programs/tools/fileExplorer")
        elseif selected == 2 then
            shell.run("/VoidOS/system/programs/tools/fileTransfer")
        elseif selected == 3 then
            shell.run("/VoidOS/system/programs/tools/newAccount")
        elseif selected == 4 then
            shell.run("/VoidOS/system/programs/tools/update")
        elseif selected == 5 then
            toolsMenu.setVisible(false)
            currentMenu.menu = mainMenu currentMenu.title = "Main Menu" menuOptions = mainMenuOptions
            mainMenu.setVisible(true)
        end
    end
end
