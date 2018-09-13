-- Flatten.lua by valvate
-- Inspired by nitrogen fingers
-- Warning! this program does not check fuel or blocks
-- it will place anything it has

-- Manage args --
local args = { ... }
if #args ~= 1 then
  print('Usage: flatten <diamater>')
  error()
end
-- Varables --
local diamater = tonumber(args[1])
local side = 'right'
local debug = false
-- Functions --
function info(info)
  -- Made this so i can add wireless later
  print(info)
end

function getDirt()
  -- Selects a dirt block
  if turtle.getItemCount() == 0 then
    turtle.select(turtle.getSelectedSlot() + 1)
  end
end
function printDebug(info)
  if debug then
    print(info)
  end
end
function process_up()
  local y = 0
  while turtle.detectUp() do
    turtle.digUp()
    turtle.up()
    y=y+1
  end
  if y >= 0 then
    for i=1,y do
      turtle.down()
    end
  end
end
function isdirtDown()
  local _, blocktable = turtle.inspectDown()
  local block = blocktable.name
  local dirts = {
    'minecraft:dirt',
    'minecraft:grass'
  }
  for i=1,#dirts do
    if block then
      printDebug('Testing dirts['..i..'] on '..block)
    end
    if block == dirts[i] then
      printDebug('Block matched '..dirts[i])
      return true
    end
  end
  return false
end
function process_down()
  if not isdirtDown() then
    turtle.digDown() 
    getDirt()
    printDebug('Placing dirt down')
    turtle.placeDown()
  end
end
function line(amount)
  for i=1,amount do
    process_down()
    process_up()
    if turtle.detect then turtle.dig() end
      turtle.forward()
    end
end

function nextline()
  if side == 'right'  then
    turtle.turnRight()
    line(1)
    turtle.turnRight()
  elseif side == 'left' then
    turtle.turnLeft()
    line(1)
    turtle.turnLeft()
  end
  -- Inverts side
  if side == 'right' then 
    side = 'left'
  elseif side == 'left' then 
    side = 'right' 
  end
end

-- Program start --
for i=1,diamater do
    line(diamater)
    nextline()
end
