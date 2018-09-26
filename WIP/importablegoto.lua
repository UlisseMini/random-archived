-- Cords library by valvate

local function moveto(orientation, x, y, z, xTarget, yTarget, zTarget)
  -- Loop starts at zero since my list starts at index 0
  local debug_level = 4
    
    -- Turtle orientation 
  local orientations = {
    [0] = "north",
    [1] = "east",
    [2] = "south",
    [3] = "west"
  }

  -- Makes sure orientation is correct
  if orientation ~= 'north' and 'south' and 'west' and 'east' then
    print('Orientation must be north south east or west')
    error()
  end
  
  -- Turns orientation from a string into a number
  -- so i can use mAtH
  for i=0,#orientations do
    if orientation == orientations[i] then
      orientation = i
      break
    end
  end

  -- zDiff and xDiff
  -- Had to be tables starting at 0 to match orientation
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
  -- Logging function 
  local function log(msg, msg_debug_level) 
    if debug_level <= msg_debug_level then 
      print(msg) 
    end 
  end 

  -- Turn to an orientation 
  local function look(direction)
    -- Could make this faster but i'm lazy
    while direction ~= orientations[orientation] do
      log('[DEBUG] I am now facing '..orientations[orientation], 4)
      right()
    end
  end

  -- Moving forward
  local function forward()
    -- If the turtle can't move keep trying 
    while not(turtle.forward()) do
      sleep(0.1)
    end
      -- Change x and z cords
      x = x + xDiff[orientation]
      z = z + zDiff[orientation]
      -- Does not return a value since it will keep trying until it can move
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
  -- made this global cuz i was getting an error when
  -- the other function used it
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
  -- Function to print cords
  local function printCords()
    print('[DEBUG] X: '..x..' Y: '..y..' X: '..z)
  end

      -- Moves to y
  while yTarget < y do
    turtle.digDown()
    down()
  end

  while yTarget > y do
    turtle.digUp()
    up()
  end
  -- Turns to correct orientation then moves forward until its at the right x cord
  if xTarget < x then
    look('west')
    while xTarget < x do
      turtle.dig()
      forward()
    end
  end
  if xTarget > x then
    look('east')
    while xTarget > x do
      turtle.dig()
      forward()
    end
  end

  -- Turns to correct orientation then moves forward until its at the right z cord
  if zTarget < z then
    look('north')
    while zTarget < z do
      turtle.dig()
      forward()
    end
  end
  if zTarget > z then
    look('south')
    while zTarget > z do
      turtle.dig()
      forward()
    end
  end
end
printCords()
moveto(dX, dY, dZ)
printCords()
