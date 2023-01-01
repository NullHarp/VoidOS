local util = require("/VoidOS/system/core/api/util")
local sha = require("/VoidOS/system/core/api/sha2")
util.title("New Account")

local x,y = term.getSize()

-- Functions
local function createAccount()
    local function newPassword()
        util.title("New Account")
        term.setCursorPos(1,y)
        term.write("[Right-Shift to cancel]")
        term.setCursorPos(1,4)
        term.write("Username:        ")
        term.setCursorPos(1,5)
        term.write("Password:        ")
        term.setCursorPos(1,6)
        term.write("Retype Password: ")
        term.setCursorPos(18,4)
        username = read()
        term.setCursorPos(18,5)
        password = read("*")
        term.setCursorPos(18,6)
        retypePassword = read("*")
        
    end
    newPassword()
    while not successfulAccount do
        if not fs.exists("/VoidOS/users/"..username) then
            if password == retypePassword then
                hashedPassword = sha.hash256(password)
                local user = fs.open("/VoidOS/users/"..username,"w")
                user.write(hashedPassword)
                user.close()
                print("Account Created")
                sleep(1)
                successfulAccount = true
            else
                util.title("New Account")
                term.setCursorPos(1,4)
                term.write("Passwords don't match.")
                sleep(1)
                newPassword()
            end
        else
            util.title("New Account")
            term.setCursorPos(1,4)
            term.write("Account already exists.")
            sleep(1)
            newPassword()
        end
    end
end

-- Backend
local successfulAccount = false

local function exit()
    while true do
        local event, key, is_held = os.pullEvent("key")
        if key == keys.rightShift then
            shell.run("/VoidOS/system/core/menu/mainMenu tool")
        end
    end
end
parallel.waitForAny(createAccount,exit)