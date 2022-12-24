function createMenu(menu,menuRun,x,y)
    local selected = 1
    term.setCursorPos(x,y)
    term.clearLine()
    local oldX,oldY = x,y
        local function drawMenu()
            term.setCursorPos(oldX,oldY)
            x,y = oldX,oldY
            for index, value in ipairs(menu) do
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
    drawMenu()
    while true do
        local event, key, isHeld = os.pullEvent("key")
        if key == keys.up and selected > 1 then
            selected = selected - 1
            drawMenu()
        elseif key == keys.down and selected < table.maxn(menu) then
            selected = selected + 1
            drawMenu()
        elseif key == keys.enter then
            shell.run(menuRun[selected])
        end
    end
end

return {createMenu = createMenu}