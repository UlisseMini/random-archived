local args = { ... }
if #args ~= 4 then
    print('Usage: melon <side> <melons> <space between> <sleeptime>')
    return
else
    local side = args[1]
    local melons = tonumber(args[2])
    -- fixes some bug i dont know where the bug is
    local melons = melons - 1
    local space = tonumber(args[3])
    local sleeptime = tonumber(args[4])
end

local function checkformelon()
    -- add compare here once i get melon block
    if turtle.detect() then
        return true
    else
        return false
    end
end

local function checkfuel()
  turtle.select(16)
  if turtle.getFuelLevel() <= (melons * space) then
      print('Waiting for fuel')
  end
  while turtle.getFuelLevel() <= (melons * space) do
    sleep(0.1)
    turtle.refuel(1)
  end
  -- return true   
end
local function nextmelon()
  if side == 'left' then
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
  elseif side == 'right' then
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
  else
    print('Side is not right or left exiting with error')
    error()
  end
end
local function swapside()
  if side == 'right' then
    return 'left'
  elseif side == 'left' then
    return 'right'
  else
    print('Side is not left or right exiting')
    error()
  end
end
while true do
  for i=1,melons do
  if checkformelon() then
    -- if there is a melon break it
    print('Melon grew collecting it...')
    turtle.dig()
  end -- end if statement
  nextmelon()
  end -- end for loop
  -- swaps side
  side = swapside()
  print('Checking fuel...')
  checkfuel()
  print('Sleeping for '..tostring(sleeptime)..' seconds')
  sleep(sleeptime)
end -- end while loop 
