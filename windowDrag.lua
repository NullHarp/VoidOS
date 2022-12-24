local old_term = term.current()
local win = window.create(old_term, 2, 2, 21, 11, false)
term.setBackgroundColor(colors.cyan)
term.clear()
win.setBackgroundColor(colors.black)
win.setVisible(true)
win.clear()
local sX,sY = win.getSize()
local function windowDraw()
    while true do
        local event, button, x, y = os.pullEvent("mouse_drag")
        term.clear()
        win.setCursorPos(1,1)
        win.write("Blank Window")
        win.setCursorPos(sX-4,1)
        win.setBackgroundColor(colors.lightGray)
        win.write("- \135 X")
        win.setBackgroundColor(colors.black)
        win.reposition(x, y , 21, 11 , old_term)
        term.clear()
        win.redraw()
    end
end

local function windowManage()
   while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if x == sX - 4 and y == 1 then
            win.setVisible(false)
        end
   end 
end
parallel.waitForAll(windowDraw,windowManage)