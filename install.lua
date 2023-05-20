local githubPath = "https://raw.githubusercontent.com/NullHarp/VoidOS/master/"

local dirToMake = {
    "VoidOS/system/core/api",
    "VoidOS/system/core/menu",
    "VoidOS/system/programs/tools",
    "VoidOS/users"
}

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
    "VoidOS/system/programs/tools/update.lua",
    "VoidOS/users/user"
}

print("Confirm VoidOS install? Y/N")
local response = string.lower(tostring(read()))
if string.find(response,"y") then
    print("Installing VoidOS.")
    print()
else
    error("VoidOS install stopped.")
end

for i,path in pairs(dirToMake) do
    fs.makeDir(path)
    print("Created path: "..path)
end


for i,path in pairs(fileToGet) do
    local file = http.get(githubPath..path)
    local data = file.readAll()
    local fileHandle = fs.open(path,"w")
    fileHandle.write(data)
    file.close()
    print("Installed: "..path)
end

print("Auto Boot VoidOS on startup? Y/N")
local response = string.lower(tostring(read()))
if string.find(response,"y") then
    print("Installing startup.")
    local file = http.get("https://raw.githubusercontent.com/NullHarp/VoidOS/master/startup.lua")
    local data = file.readAll()
    local fileHandle = fs.open("/startup.lua","w")
    fileHandle.write(data)
    file.close()
end
print("Install complete, default username and password is user")