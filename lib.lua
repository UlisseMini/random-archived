-- Valvates library for cordanite management and stuff.
-- If you have an idea for feature make an issue or
-- Create a pull request if you're a coder.
-- A lot of stuff here is unfinished so
-- Be careful and tell me how to make it better :DD

-- WARNING!
-- Since the turtle writes his coordanites to a file you should
-- run fs.delete(t.cordsfile) when your program finishes!
-- if you don't then his coords will get all screwed up if he moved without updating his coords

-- If you're using gps you can manually set coords and then update them 
-- heres some untested example code

--[[
t = require('lib')
t.x, t.y, t.z = gps.locate(0.5)
-- In this example orientation is still set to north by default,
-- if you want to find orientation you'll need code that compares cords
-- after you move, i might add this later but for now its up to you! ;)

--]]

local t = {}


-- Debug level of messages to display. (see log function)
-- I use level 1 as error 2 as Warning 3 as Info and 4 for debug.
t.debug_level = 4

-- Files
t.logfile = 'tLib.log'
t.cordsfile = 'cords'
t.posfile = 'savedPositions'

local file -- Used for file management
t.saved_positions = {}-- Table for saving positions

t.blocks_dug = 0 -- Blocks dug

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
t.orientations = {
  [0] = "north",
  [1] = "east",
  [2] = "south",
  [3] = "west"
}

-- Unwanted items for clean inventory function.
t.unWantedItems = {
  'minecraft:cobblestone',
  'minecraft:stone',
  'minecraft:flint',
  'minecraft:dirt',
  'minecraft:sandstone',
  'minecraft:sand'
}

-- Checks if a value is in a table.
function t.inTable(value, table)
  for key, v in ipairs(table) do
    if value == value then
      return true
    end
  end
  -- if its not in the table then
  return false
end

function t.cleanInventory()
  local item
  local prevSlot = turtle.getSelectedSlot()

  for i=1,16 do
    item = turtle.getItemDetail(i)
    -- Makes sure item exists to avoid nil errors.
  if item and t.inTable(item.name, t.unWantedItems) then
    turtle.select(i)
    turtle.dropDown(item.count) -- Drops all of the unwanted item
  end
    turtle.select(prevSlot) -- Leave no trace!
  end
end

function t.writeToFile(msg, file, mode)
  -- Function used by logging function.
  -- i felt it was cleaner this way.
  if mode == nil then
    mode = 'a' -- By default append
  end

  if file == nil then
    file = t.logfile -- default
  end
  
  fileHandle = fs.open(file, mode)
  fileHandle.write(msg..'\n') -- Adds newline
  fileHandle.close()
end

function t.log(msg, msg_debug_level)
  -- Logging function
  
  if msg_debug_level == nil then
    t.writeToFile('[WARNING] msg_debug_level is nil, defaulting to level 3 message info.', t.logfile)
    -- As a param this is already local.
    msg_debug_level = 3
  end

  if msg_debug_level <= t.debug_level then
    t.writeToFile(msg, t.logfile)
  end
end

local function updatePositions()
  -- Writes saved positions to file.
  t.writeToFile.write(textutils.serialize(t.saved_positions), 'w')
end

-- Get cords from file if file does not exist create one and set coords to 0,0,0,0
function t.getCords()
  local cords
  local contents
  if t.cordsfile == nil then
    t.log('[ERROR] t.cordsfile is nil', 1)
    t.log('[WARNING] Without a cords file persistance will fail', 2)
    return -- Breaks from this function
  end
  
  if not fs.exists(t.cordsfile) then
    t.log('[WARNING] t.cordsfile does not exist', 2)
    t.log('[INFO] Creating cordsfile...', 3)
    -- Creates cords file with 0,0,0,0 as values.
    t.writeToFile(textutils.serialize({x = 0, y = 0, z = 0, orientation = 0}), t.cordsfile, 'w')
  end
  file = fs.open(t.cordsfile, 'r') -- Opens cordsfile for reading.
  contents = file.readAll()
  if not contents then
    t.log('[ERROR] contents is nil, persistance will not work!')
    return
  end

  t.log('[DEBUG] Read file contents, trying to unserialize it', 4)
  cords = textutils.unserialize(contents)
  -- Sets coordanites
  t.x = cords.x
  t.y = cords.y
  t.z = cords.z

  -- Sets orientation
  t.orientation = cords.orientation

  -- Not going to return a value since i will just change the varables.
end

-- Saves coordanites to file
local function saveCords()
  -- Commented out because it spammed logs
  --t.log('[DEBUG] Trying to write cords to file.', 4)
  --t.log('[DEBUG] t.x = '..t.x..' t.y = '..t.y..' t.z = '..t.z..'t.orientation = '..t.orientation)
  t.writeToFile(textutils.serialize({x = t.x,y = t.y, z = t.z, orientation = t.orientation}), t.cordsfile, 'w')
end

local function orientationToNumber(orientationStr)
  -- Turns an orientation string into an Orientation number.
  for i=0,#t.orientations do
      if orientationStr == t.orientations[i] then
        return i
      end
  end
end

-- Turns an orientation number into an t.orientation string.
local function orientationToString(orientationInt)
  -- Checks to see if orientationInt is a number
  if type(orientationInt) ~= 'number' then
    t.log('[ERROR] orientationInt is not a number', 1)
    error('[ERROR] OrientationInt is not a number')
  end
  if orientations[orientationInt] then
    return t.orientations[orientationInt]
  else
    print('[ERROR] Orientation is invalid', 1)
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
  saveCords()
end

function t.turnLeft()
  turtle.turnLeft()
  t.orientation = (t.orientation - 1) % 4
  saveCords()
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
  t.log('[DEBUG] t.forward called', 4)

    if turtle.forward() then
        t.log('[DEBUG] turtle.forward() returned true, changing cords...', 4)
    -- Change t.x and t.z cords
        t.x = t.x + xDiff[t.orientation]
        t.z = t.z + zDiff[t.orientation]
    saveCords()
      return true
    else
      -- If he failed to move return false and don't change the cords.
      return false
    end
end

function t.up()
  t.log('[DEBUG] t.up function called', 4)
  if turtle.up() then
    t.y = t.y + 1
    t.log('[DEBUG] Trying to save cords to file after going up', 4)
    saveCords()
    return true
  else
    return false
  end
end

function t.down()
  if turtle.down() then
    t.y = t.y - 1
    saveCords()
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

-- This function saves the turtles position so it can be returned to later.
function t.saveCurrentPos(name)
  if type(name) ~= 'string' then
    error('Position name must be a string.')
  end

  -- Creates a new table entry with "name" key
  t.saved_positions[name] = {
    x = t.x,
    y = t.y,
    z = t.z,
    orientation = t.orientation
  }
end

function t.savePosisionsToFile()
  t.writeToFile(textutils.serialize(t.saved_positions), t.posfile, 'w')
end

function t.getPos()
  if fs.exists(t.posfile) then
    file = fs.open(t.posfile, 'r')
    t.saved_positions = textutils.unserialize(file.readAll())
    file.close()
  else
    error('No file to get positions from.')
  end
end

function t.gotoPos(name)
  if t.saved_positions[name] == nil then error('[ERROR] t.saved_positions['..name..'] is nil') end
  for i,v in ipairs(t.saved_positions[name]) do print(i,v) end -- temp
  
  t.goto(t.saved_positions[name].x, t.saved_positions[name].y, t.saved_positions[name].z, t.saved_positions[name].orientation)
end

-- Careful this breaks blocks.
function t.goto(xTarget, yTarget, zTarget, orientationTarget)
  if not xTarget or not yTarget or not zTarget or not orientationTarget then
    t.log('[DEBUG] Here are all the params for the goto function:', 4)
    t.log('xTarget='..xTarget..'yTarget='..yTarget..'zTarget='..zTarget..'orientationTarget='..orientationTarget, 4)
    error('t.goto Can\'t travel to nil!, read logs for more info')
  end
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
  -- Look to correct orientation
  t.look(orientationTarget)
end
-- Because its not defined at the top
t.getCords()
return t
