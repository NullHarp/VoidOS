local util = require("/VoidOS/system/core/api/util")
local sha = require("/VoidOS/system/core/api/sha2")
util.title("Lockscreen")

term.write("Username: ")
term.setCursorPos(1,5)
term.write("Password: ")

term.setCursorPos(11,4)
local username = read()

term.setCursorPos(11,5)
local password = read("*")

if fs.exists("VoidOS/users/"..username) and not fs.isDir("VoidOS/users/"..username) then
    local hashedPassword = sha.hash256(password)
    local file = fs.open("VoidOS/users/"..username,"r")
    local data = file.readAll()
    if hashedPassword == data then
        util.title("Lockscreen")
        print("Access Granted")
        sleep(0.75)
        shell.run("/VoidOS/system/core/menu/mainMenu")
    else
        util.title("Lockscreen")
        term.setTextColor(colors.red)
        textutils.slowPrint("Incorrect Username or Password",15)
        term.setTextColor(colors.white)
        sleep(0.75)
        shell.run("/VoidOS/system/core/menu/lockscreen")
    end
else
    util.title("Lockscreen")
    term.setTextColor(colors.red)
    textutils.slowPrint("Incorrect Username or Password",15)
    term.setTextColor(colors.white)
    sleep(0.75)
    shell.run("/VoidOS/system/core/menu/lockscreen")
end