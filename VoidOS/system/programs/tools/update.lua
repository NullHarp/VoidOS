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


local fileToGet = {
    "VoidOS/system/core/init.lua",
    "VoidOS/system/core/api/menu.lua",
    "VoidOS/system/core/api/sha2.lua",
    "VoidOS/system/core/api/util.lua",
    "VoidOS/system/core/menu/lockscreen.lua",
    "VoidOS/system/core/menu/mainMenu.lua",
    "VoidOS/system/programs/tools/fileExplorer.lua",
    "VoidOS/system/programs/tools/fileTransfer.lua",
    "VoidOS/system/programs/tools/newAccount.lua",
    "VoidOS/system/programs/tools/update.lua"
}

for i,filePath in pairs(fileToGet) do
    local file = fs.open(filePath,"r")
    local fileData = file.readAll()
    local fileHandle = http.get(githubPath..filePath)
    local fileHandleData = fileHandle.readAll()
    textutils.pagedPrint(filePath)
    if fileData ~= fileHandleData then
        textutils.pagedPrint("File is not up to date")
        textutils.pagedPrint("Reinstalling")
        local file = fs.open(filePath,"w")
        file.write(fileHandleData)
        file.close()
    else
        print("File is up to date")
    end
end
sleep(1)
shell.run("/VoidOS/system/core/menu/mainMenu.lua tool")