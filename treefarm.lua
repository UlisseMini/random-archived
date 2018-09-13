-- WARNING THIS CODE SUCKS
-- USE AT YOUR OWN RISK
-- I COULD MAKE IT BETTER BUT
-- I'M TOO LAZY
local args = { ... }
--print(#args)
if #args ~= 3 then
  print('Usage: <side for line of trees> <number of trees> <seconds in between runs>')
  return
else
  space = 5
  side = args[1]
  trees = args[2]
  sleeptime = args[3]
  
  trees = tonumber(trees)
  sleeptime = tonumber(sleeptime)
end
function nexttreeRight()
  turtle.turnRight()
  for i=1,space do
    turtle.forward()
    --turtle.suck()
    --turtle.suck()
  end
  turtle.turnLeft()
end
function nexttreeLeft()
  turtle.turnLeft()
  for i=1,space do
    turtle.forward()
    --turtle.suck()
    --turtle.suck()
  end
  turtle.turnRight()
end
function checktree()
  turtle.select(15)
  if turtle.compare() then
    return true
  else
    return false
  end
end
function plant()
  turtle.select(14)
  if turtle.place() == false then
    turtle.forward()
    turtle.select(13)
    turtle.placeDown()
    turtle.back()
  end
  turtle.select(14)
  turtle.place()
end
function digtree()
  turtle.dig()
  turtle.forward()
  while turtle.detectUp() do
    turtle.digUp()
    turtle.up()
  end
  while turtle.detectDown() == false do
    turtle.down()
  end
  turtle.back()
  plant()
end
function check_fuel()
  fuel = turtle.getFuelLevel()
  if fuel < trees * space then
    rednet.send('Low on fuel refueling...')
    turtle.select(16)
    if turtle.refuel(1) == false then
      print('Out of fuel put fuel in slot 16')
    end
    while turtle.refuel(1) == false do
      sleep(1)
    end
  end
end
function dumpitemstochest()
  for i = 1,11 do
    turtle.select(i)
    turtle.dropUp(63)
  end
end
function main()
  while true do
    for i=1,trees do
      if checktree() then
        print('Cutting down tree')
        digtree()
      elseif turtle.detect() == false then
        print('Planting tree')
        plant()
      end
      if side == 'left' then
        nexttreeLeft()
      elseif side == 'right' then
        nexttreeRight()    
      
      end
    end
    if side == 'right' then side = 'left' elseif side == 'left' then side = 'right' end
    print('sleeping for '..sleeptime..' seconds...')
    sleep(sleeptime)
    check_fuel()
    if turtle.getItemCount(11) > 1 and side == 'right' then
      dumpitemstochest()
    end
  end
end
main()
