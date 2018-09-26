-- Program to goto cords
-- WARNING WILL BREAK BLOCKS IN HIS WAY

-- Args --
local args = { ... }
if #args ~= 7 then
  print('Usage: goto <turtleX> <turtleY> <turtleZ> <destX> <destY> <destZ> <turtleOrientation>')
  error()
end

-- Varables --
local debug_level = 4
-- Turtle cords
local x = tonumber(args[1])
local y = tonumber(args[2])
local z = tonumber(args[3])

-- Turtle orientation 
local orientation = tonumber(args[7]) -- orientation
local orientations = {
  [0] = "north",
  [1] = "east",
  [2] = "south",
  [3] = "west"
}

-- Makes sure orientation is a string
if type(orientation) ~= 'string' then
  print('Orientation must be north east west or south')
  error()
end

-- Turns orientation from a string into its number
for i=0,#orientations do
  if orientation == orientations[i] then
    orientation = i
    break
  end
end

-- Destination cords
local dX = tonumber(args[4])
local dY = tonumber(args[5])
local dZ = tonumber(args[6])

-- Logging function
local function log(msg, msg_debug_level)
  if debug_level < msg_debug_level then
    print(msg)
  end
end

-- Moving up and down
local function up()
  turtle.digUp()
  if turtle.up() then 
    y = y + 1
    return true
  else
    return false
  end
end

local function down()
  turtle.digDown()
  if turtle.down() then 
    y = y - 1
    return true
  else
    return false
  end
end

-- Turning functions
-- Store it in an integer. Turn right? facing = facing + 1 % 4  Turn left? facing = facing +3 % 4
local function right()
  turtle.turnRight()
  -- Orientation
  orientation = (orientation + 1) % 4
end

local function left()
  turtle.turnLeft()
  -- Orientation
  orientation = (orientation - 1) % 4
end

-- Main moveto function
local function moveto(x, y, z)
  -- Work in progress function so far only does y (orientation is a bitch)
  -- Moves to y
  while dY <= y do
    turtle.digDown()
    down()
  end

  while dY >= y do
    turtle.digUp()
    up()
  end

end
-- Tests orientation

for i=1,5 do
  right()
  log('[DEBUG] i am looking '..orientations[orientation])
end

for i=1,5 do
  left()
  log('[DEBUG] i am looking '..orientations[orientation])
end
