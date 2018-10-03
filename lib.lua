-- Custom functions i use in a few programs --

local lib = {}

-- Cords and orientation all starting at 0
local x, y, z = 0, 0 ,0
local orientation = 0

-- Table for saving posisions
local saved_positions = {}
local blocks_dug = 0

-- Diference in cords with diferent orientations
local zDiff = {
	[0] = -1,
	[1] = 0,
	[2] = 1,
	[3] = 0
}

local xDiff = { 
  [0] = 0,
  [1] = 1,
  [2] = 0,
  [3] = -1
}

-- Needed for human readable input/output
local orientations = {
	[0] = "north",
	[1] = "east",
	[2] = "south",
	[3] = "west"
}

local function orientationToNumber(orientationStr)
	-- Turns an orienation string into an orientation number.
	for i=0,#orientations do
	    if orientationStr == orientations[i] then
	      return i
	    end
	end
end

local function orientationToString(orientationInt)
	-- Turns an orienation number into an orientation string.
	if orienations[orienationInt] then
		return orientations[orientationInt]
	else
		print('Orientation is invalid.')
		print('orientationInt = '..orientationInt)
		error()
	end
end

-- Turning functions
function lib.turnRight()
	turtle.turnRight()
	-- This "magic" math adds one to orientation unless orientation is 3, then it moves to 0.
	-- This could also be done with an if statement but this is cleaner imo
	orientation = (orientation + 1) % 4
end

function lib.turnLeft()
	turtle.turnLeft()
	orientation = (orientation - 1) % 4
end

-- Looks to a direction, can be passed a string or a number
function lib.look(direction)
	-- makes sure the value passed is valid.
	if type(direction) == 'string' then
		direction = orientationToNumber(direction)
	
	elseif type(direction) ~= 'number' then
    error('Direction is not a number')
  end

	-- I've gotta find a beter way :P
	while orientation ~= direction do
	  lib.turnRight()
	end
end

function lib.forward()
    if turtle.forward() then
      	-- Change x and z cords
      	x = x + xDiff[orientation]
      	z = z + zDiff[orientation]
    	return true
    else
    	-- If he failed to move return false and don't change the cords.
    	return false
    end
end

function lib.up()
	if turtle.up() then
		y = y + 1
		return true
	else
		return false
	end
end

function lib.down()
	if turtle.down() then
		y = y - 1
		return true
	else
		return false
	end
end

function lib.digDown()
	if turtle.digDown() then
		blocks_dug = blocks_dug + 1
		return true
	else
		return false
	end
end
function lib.dig()
	if turtle.dig() then
		blocks_dug = blocks_dug + 1
		return true
	else
		return false
	end
end
function lib.digUp()
	if turtle.digUp() then
		blocks_dug = blocks_dug + 1
		return true
	else
		return false
	end
end

-- This function saves the turtles posision so it can be returned to later.
function lib.savePos(name)
	if type(name) ~= 'string' then
		error('Position name must be a string.')
	end

	saved_positions[name] = {
		x = x,
		y = y,
		z = z,
		orientation = orientation
	}
end
function lib.gotoPos(name)
	lib.goto(saved_positions[name].x, saved_positions[name].y, saved_positions[name].z)
  -- Looks the way you were looking when you took the snapshot.
  lib.look(saved_positions[name].orientation)
end
-- Careful this breaks blocks.
function lib.goto(xTarget, yTarget, zTarget)
  -- Moves to y
  while yTarget < y do
    lib.digDown()
    lib.down()
  end

  while yTarget > y do
    lib.digUp()
    lib.up()
  end

  -- Turns to correct orientation then moves forward until its at the right x cord
  if xTarget < x then
    lib.look('west')
    while xTarget < x do
      lib.dig()
      lib.forward()
		end
  end

  if xTarget > x then
    lib.look('east')
    while xTarget > x do
      lib.dig()
      lib.forward()
    end
  end

  -- Turns to correct orientation then moves forward until its at the right z cord
  if zTarget < z then
    lib.look('north')
    while zTarget < z do
      lib.dig()
      lib.forward()
    end
  end
  if zTarget > z then
    lib.look('south')
    while zTarget > z do
      lib.dig()
      lib.forward()
    end
  end
end

return lib
