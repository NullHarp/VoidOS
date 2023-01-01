local util = require("/VoidOS/system/core/api/util")
local maxX, maxY = term.getSize()
local old_term = term.current()

function createMenu()
    local win = window.create(old_term,1,1,maxX,maxY,false)
    return win
end

function runMenu(menuOptions,menuTerm,x,y,titleText)
    term.redirect(menuTerm)
    util.title(titleText)
    local selected = 1
    term.setCursorPos(x,y)
    term.clearLine()
    local oldX,oldY = x,y
    local function drawMenu()
        term.setCursorPos(oldX,oldY)
        x,y = oldX,oldY
        for index, value in ipairs(menuOptions) do
            term.setCursorPos(x,y)
            term.clearLine()
            if index == selected then
                term.write("[ "..value.." ]")
            else
                term.write("  "..value.."  ")
            end
        y = y + 1
        end
    end
    local function maintainWindow()
        local selectedOption = false
        while not selectedOption do
            local event, key, isHeld = os.pullEvent("key")
            if key == keys.up and selected > 1 then
                selected = selected - 1
                drawMenu()
            elseif key == keys.down and selected < table.maxn(menuOptions) then
                selected = selected + 1
                drawMenu()
            elseif key == keys.enter then
                selectedOption = true
            end
        end
    end
    drawMenu()
    maintainWindow()
    return selected
end
return {createMenu = createMenu,runMenu = runMenu}