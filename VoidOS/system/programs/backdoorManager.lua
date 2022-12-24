local util = require("/VoidOS/system/core/api/util")
util.title("Backdoor Manager by NullHarp")
term.write("Computer ID: ")
local id = read()
term.setCursorPos(1,5)
term.write("Command Type: ")
local commandType = read()
if commandType == "install" then
    term.setCursorPos(1,6)
    term.write("File Name: ")
    local filename = read()
    if fs.exists(filename) then
        local file = fs.open(filename,"r")
        local data = file.readAll()
        local package = textutils.serialiseJSON({name = "install",data = data,filename = filename})
        rednet.open("top")
        rednet.send(tonumber(id), data,"69420")
    end
end
