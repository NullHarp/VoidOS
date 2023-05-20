local util = require("/VoidOS/system/core/api/util")
local githubPath = "https://raw.githubusercontent.com/NullHarp/VoidOS/master/"

util.title("Updater")

print("Confirm VoidOS update? Y/N")
local response = string.lower(tostring(read()))
if string.find(response,"y") then
    print("Updating VoidOS.")
    print()
else
    error("VoidOS update stopped.")
    sleep(1)
    shell.run("/VoidOS/system/core/menu/mainMenu.lua tool")
end

local file = fs.open("/VoidOS/system/programs/tools/update.lua","r")
local fileData = file.readAll()
file.close()

local fileHandle = http.get(githubPath.."VoidOS/system/programs/tools/update.lua")
local fileHandleData = fileHandle.readAll()

if fileData ~= fileHandleData then
    local file = fs.open("/VoidOS/system/programs/tools/update.lua","w")
    file.write(fileHandleData)
    file.close()
    shell.run("/VoidOS/system/programs/tools/update.lua")
end

local fileToGet = {
    "VoidOS/system/core/init.lua",
    "VoidOS/system/core/api/menu.lua",
    "VoidOS/system/core/api/sha2.lua",
    "VoidOS/system/core/api/util.lua",
    "VoidOS/system/core/menu/lockscreen.lua",
    "VoidOS/system/core/menu/mainMenu.lua",
    "VoidOS/system/programs/tools/fileExplorer.lua",
    "VoidOS/system/programs/tools/fileTransfer.lua",
    "VoidOS/system/programs/tools/newAccount.lua"
}

for i,filePath in pairs(fileToGet) do
    local file = fs.open(filePath,"r")
    local fileData
    if type(file) ~= "nil" then
        fileData = file.readAll()
        file.close()
    end
    local fileHandle = http.get(githubPath..filePath)
    local fileHandleData = fileHandle.readAll()
    textutils.pagedPrint(filePath)
    if type(file) ~= "nil" then
        if fileData ~= fileHandleData then
            textutils.pagedPrint("Updating")
            local file = fs.open(filePath,"w")
            file.write(fileHandleData)
            file.close()
        else
            print("File is up to date")
        end
    else
        textutils.pagedPrint("File not found.")
        textutils.pagedPrint("Reinstalling")
        local newFile = fs.open(filePath,"w")
        newFile.write(fileHandleData)
        newFile.close()
    end
end
sleep(1)
shell.run("/VoidOS/system/core/menu/mainMenu.lua tool")