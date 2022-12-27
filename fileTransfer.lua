local side, mode, id, file = ...

if side == nil or mode == nil or id == nil then
    error("Side, Mode, Id, #optionalFile")
end

if not peripheral.find("modem") then
    error("Modem required")
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
end