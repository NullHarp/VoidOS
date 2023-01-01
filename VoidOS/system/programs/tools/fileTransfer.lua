local util = require("/VoidOS/system/core/api/util")
util.title("File Transfer")

term.write("Side: ")
term.setCursorPos(1,5)
term.write("Mode: ")
term.setCursorPos(1,6)
term.write("Id:   ")
term.setCursorPos(7,4)
local side = read()
term.setCursorPos(7,5)
local mode = read()
term.setCursorPos(7,6)
local id = read()

if mode == "send" then
    term.setCursorPos(1,7)
    term.write("File: ")
    term.setCursorPos(7,7)
    file = read()
end


if side == nil or mode == nil or id == nil then
    error("Side, Mode, Id, #optionalFile")
    sleep(1)
    shell.run("/VoidOS/system/core/menu/mainMenu tool")
end

if not peripheral.find("modem") then
    error("Modem required")
    sleep(1)
    shell.run("/VoidOS/system/core/menu/mainMenu tool")
end

rednet.open(side)
id = tonumber(id)

if mode == "receive" then
    local fileReceived = false
    while not fileReceived do
        local ID, msg = rednet.receive()
        if type(msg) == "table" and ID == id then
            local fileHandle = fs.open(msg.fileName,"w")
            fileHandle.write(msg.fileData)
            fileHandle.close()
            fileReceived = true
        end
    end
elseif mode == "send" then
    if file == nil then
        error("Side, Mode, Id, #requiredFile")
        sleep(1)
        shell.run("/VoidOS/system/core/menu/mainMenu tool")
    end
    if fs.exists(file) and not fs.isDir(file) then
        local fileHandle = fs.open(file,"r")
        local fileData = fileHandle.readAll()
        local package = {fileName = file,fileData = fileData}
        rednet.open(side)
        rednet.send(id,package)
    end
else
    error("Not accepted mode "..mode.." please use receive or send")
    sleep(1)
    shell.run("/VoidOS/system/core/menu/mainMenu tool")
end
sleep(1)
shell.run("/VoidOS/system/core/menu/mainMenu tool")