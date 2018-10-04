-- Valvates library for cordanite management and stuff.
-- If you have an idea for feature make an issue or
-- Create a pull request if you're a coder.

local t = {}

-- Cords and t.orientation all starting at 0
t.x, t.y, t.z = 0, 0 ,0
-- Orientation
t.orientation = 0

-- Table for saving posisions
t.saved_posisions = {}

-- Blocks dug
t.blocks_dug = 0

-- Diference in cords with diferent t.orientations
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
t.orientations = {
	[0] = "north",
	[1] = "east",
	[2] = "south",
	[3] = "west"
}

local function orientationToNumber(orientationStr)
	-- Turns an orientation string into an Orientation number.
	for i=0,#t.orientations do
	    if orientationStr == t.orientations[i] then
	      return i
	    end
	end
end

local function orientationToString(orientationInt)
	-- Turns an orientation number into an t.orientation string.
	if orientations[orientationInt] then
		return t.orientations[orientationInt]
	else
		print('Orientation is invalid.')
		print('orientationInt = '..orientationInt)
		error()
	end
end

-- Turning functions
function t.turnRight()
	turtle.turnRight()
	-- This "magic" math adds one to t.orientation unless t.orientation is 3, then it moves to 0.
	-- This could also be done with an if statement but this is cleaner imo
	t.orientation = (t.orientation + 1) % 4
end

function t.turnLeft()
	turtle.turnLeft()
	t.orientation = (t.orientation - 1) % 4
end

-- Looks to a direction, can be passed a string or a number
function t.look(direction)
	-- makes sure the value passed is valid.
	if type(direction) == 'string' then
		direction = orientationToNumber(direction)
	
	elseif type(direction) ~= 'number' then
    error('Direction is not a number')
  end

	-- Thanks to Incin for this bit of code :)
	if direction == t.orientation then return end
	
	if (direction - t.orientation) % 2 == 0 then
		t.turnLeft()
		t.turnLeft()
	elseif (direction - t.orientation) % 4 == 1 then
		t.turnRight()
	else
		t.turnLeft()
	end
end

function t.forward()
    if turtle.forward() then
      	-- Change t.x and t.z cords
      	t.x = t.x + xDiff[t.orientation]
      	t.z = t.z + zDiff[t.orientation]
    	return true
    else
    	-- If he failed to move return false and don't change the cords.
    	return false
    end
end

function t.up()
	if turtle.up() then
		t.y = t.y + 1
		return true
	else
		return false
	end
end

function t.down()
	if turtle.down() then
		t.y = t.y - 1
		return true
	else
		return false
	end
end

function t.digDown()
	if turtle.digDown() then
		t.blocks_dug = t.blocks_dug + 1
		return true
	else
		return false
	end
end
function t.dig()
	if turtle.dig() then
		t.blocks_dug = t.blocks_dug + 1
		return true
	else
		return false
	end
end
function t.digUp()
	if turtle.digUp() then
		t.blocks_dug = t.blocks_dug + 1
		return true
	else
		return false
	end
end

-- This function saves the turtles posision so it can be returned to later.
function t.saveCurrentPos(name)
	if type(name) ~= 'string' then
		error('Position name must be a string.')
	end

	-- Creates a new table entry with "name" key
	t.saved_posisions[name] = {
		x = t.x,
		y = t.y,
		z = t.z,
		orientation = t.orientation
	}
end

function t.gotoPos(name)
	t.goto(t.saved_posisions[name].x, t.saved_posisions[name].y, t.saved_posisions[name].z)
  -- Looks the way you were looking when you took the snapshot.
  t.look(t.saved_posisions[name].orientation)
end

-- Careful this breaks blocks.
function t.goto(xTarget, yTarget, zTarget)
  -- Moves to t.y
  while yTarget < t.y do
    t.digDown()
    t.down()
  end

  while yTarget > t.y do
    t.digUp()
    t.up()
  end

  -- Turns to correct t.orientation then moves forward until its at the right t.x cord
  if xTarget < t.x then
    t.look('west')
    while xTarget < t.x do
      t.dig()
      t.forward()
		end
  end

  if xTarget > t.x then
    t.look('east')
    while xTarget > t.x do
      t.dig()
      t.forward()
    end
  end

  -- Turns to correct t.orientation then moves forward until its at the right t.z cord
  if zTarget < t.z then
    t.look('north')
    while zTarget < t.z do
      t.dig()
      t.forward()
    end
  end
  if zTarget > t.z then
    t.look('south')
    while zTarget > t.z do
      t.dig()
      t.forward()
    end
  end
end

return t