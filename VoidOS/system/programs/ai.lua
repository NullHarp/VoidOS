-- Set the size of the cube
local size = 10

-- Set the initial rotation of the cube
local rotX = 0
local rotY = 0
local rotZ = 0

-- Create a table of points representing the vertices of the cube
local vertices = {
    {-1, -1, -1},
    {-1, -1, 1},
    {-1, 1, -1},
    {-1, 1, 1},
    {1, -1, -1},
    {1, -1, 1},
    {1, 1, -1},
    {1, 1, 1},
}

-- Create a table of lines connecting the vertices of the cube
local lines = {
    {1, 2},
    {1, 3},
    {1, 5},
    {2, 4},
    {2, 6},
    {3, 4},
    {3, 7},
    {4, 8},
    {5, 6},
    {5, 7},
    {6, 8},
    {7, 8},
  }

local function project(x, y, z)
    -- Calculate the scaling factor based on the distance from the viewer
    local f = size / 2 / (z + size)
  
    -- Calculate the width and height of the screen
    local screenWidth, screenHeight = term.getSize()
  
    -- Calculate the x and y coordinates of the projected point, taking into
    -- account the aspect ratio of the screen
    local xP = (x * f + 1) * screenWidth / 2
    local yP = (y * f + 1) * screenHeight / 2
  
    return xP, yP
  end
  

-- Function to rotate a 3D point around the X, Y, and Z axes
local function rotate(x, y, z)
    local cX = math.cos(rotX)
    local sX = math.sin(rotX)
    local cY = math.cos(rotY)
    local sY = math.sin(rotY)
    local cZ = math.cos(rotZ)
    local sZ = math.sin(rotZ)

    local x1 = x
    local y1 = cX * y - sX * z
    local z1 = sX * y + cX * z

    local x2 = cY * x1 + sY * z1
    local y2 = y1
    local z2 = -sY * x1 + cY * z1

    local x3 = cZ * x2 - sZ * y2
    local y3 = sZ * x2 + cZ * y2
    local z3 = z2

    return x3, y3, z3
end
-- Function to draw the cube on the screen
local function drawCube()
    -- Clear the screen
    term.setBackgroundColor(colors.black)
    term.clear()
    
    -- Draw the lines connecting the vertices of the cube
    for _, line in ipairs(lines) do
      local x1, y1, z1 = rotate(vertices[line[1]][1], vertices[line[1]][2], vertices[line[1]][3])
      local x2, y2, z2 = rotate(vertices[line[2]][1], vertices[line[2]][2], vertices[line[2]][3])
      local x1p, y1p = project(x1, y1, z1)
      local x2p, y2p = project(x2, y2, z2)
      term.setCursorPos(math.floor(x1p), math.floor(y1p))
      term.setBackgroundColor(colors.white)
      term.write(" ")
      term.setCursorPos(math.floor(x2p), math.floor(y2p))
      term.setBackgroundColor(colors.white)
      term.write(" ")
      
      -- Draw the line connecting the two points
      local dx = x2p - x1p
      local dy = y2p - y1p
      local steps = math.max(math.abs(dx), math.abs(dy))
      for i = 1, steps do
        local x = x1p + dx * (i / steps)
        local y = y1p + dy * (i / steps)
        term.setCursorPos(math.floor(x), math.floor(y))
        term.setBackgroundColor(colors.white)
        term.write(" ")
      end
    end
  end

-- Loop forever, updating the cube's rotation and redrawing it on the screen
while true do
    -- Update the rotation of the cube
    rotX = rotX + 0.01
    rotY = rotY + 0.02
    rotZ = rotZ + 0.03

    -- Draw the cube
    drawCube()

    -- Wait a short time before updating the rotation and redrawing again
    os.sleep(0.05)
end
