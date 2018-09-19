-- Varables --
local seeds_slot = 2
local fuel_slot = 16
-- Time between runs (in seconds)
local sleeptime = 120

-- Space between crop lines --
local space = 2
-- Side the crops are on
local side = 'right'
local turtle_side = side -- For keeping track if turtle is above or below the crops

-- How meny lines of crops do you have
local lines = 3
-- Functions
function hasGrown()
  -- Returns true if wheat has grown --
  _, block = turtle.inspectDown()
  if block.name == 'minecraft:wheat' and block.metadata == 7 then
    return true
  else
    return false
  end
end

function line(length)
  for i=1,length do
    if hasGrown() then
      turtle.digDown()
      turtle.select(seeds_slot)
      if not turtle.placeDown() then
        error('Out of seeds')
      end
    end
    turtle.forward()
  end
end

function fuel()
  -- Checks fuel and tries to refuel --
  while turtle.getFuelLevel() <= length do
    turtle.select(fuel_slot)
    if not turtle.refuel() then
      error('Out of fuel')
    end
  end
end

function next_row()
  if turtle_side == 'right' then
    turtle.turnRight()
    turtle_side = 'left'
  elseif turtle_side == 'left' then
    turtle.turnLeft()
    turtle_side = 'right'
  end
  for i=1,space do
    turtle.forward()
  end
end

-- Program start --
while true do
  for i=1,lines do
    line()
    next_row()
  end
  -- Changes side and sleeps
  if side == 'right' then
    side = 'left'
  elseif side == 'left' then
    side = 'right'
  end
  sleep(sleeptime)
end
