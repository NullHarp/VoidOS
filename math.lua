print(term.getSize())

term.redirect(peripheral.wrap("monitor_6"))
term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

-- define the parabola in standard form
local a = 1
local b = 2
local c = 5

-- calculate the x-coordinates of the vertex
local xVertex = -b / (2 * a)

-- set the starting x-coordinate
local x = xVertex - 5

-- loop until we reach the end of the parabola
while x <= xVertex + 5 do
  -- calculate the y-coordinate for the current x-coordinate
  local y = a * x * x + b * x + c

  -- draw a point at the current coordinates
    paintutils.drawPixel(math.floor(x),math.floor(y))
  -- move to the next x-coordinate
  x = x + 1
end