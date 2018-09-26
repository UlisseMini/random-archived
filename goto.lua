-- Program to goto cords
-- WARNING WILL BREAK BLOCKS IN HIS WAY

-- Args --
local args = { ... }
if #args ~= 6 then
  print('Usage: goto <turtleX> <turtleY> <turtleZ> <destX> <destY> <destZ>')
  error()
end

-- Varables --

-- Turtle cords
local x = tonumber(args[1])
local y = tonumber(args[2])
local z = tonumber(args[3])
-- Turtle orientation 
-- Copied code not using this yet
local orientation = 3
local orientations = {}

-- Destination cords
local dX = tonumber(args[4])
local dY = tonumber(args[5])
local dZ = tonumber(args[6])

-- Logging function
-- I'll expand this later
local function log(msg)
  print(msg)
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

-- other move functions (more complex)

-- Test functions

local function moveto(x, y, z)
  -- Work in progress function so far only does y (orientation is a bitch)
  while dY <= y do
    up()
  end
end
