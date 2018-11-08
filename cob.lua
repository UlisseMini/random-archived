-- Program to mine cobblestone ez clap

local dugblocks = 0
local space = 16*64

while true do
  while dugblocks <= space do
    if turtle.dig() then
      dugblocks = dugblocks + 1
    end
  end

  -- Drop into chest
  turtle.turnRight()
  turtle.turnRight()

  for i=1,16 do
    turtle.select(i)
    turtle.drop(64)
  end

  -- Go back
  turtle.turnLeft()
  turtle.turnLeft()
  -- reset blocksdug
  dugblocks = 0
end
