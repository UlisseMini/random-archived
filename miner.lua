-- Args --
local args = { ... }
if #args ~= 1 then
  print('Usage: mine <distance>')
  error()
end

-- Varables --
local distance = tonumber(args[1])
local torchslot = 15
local fuelslot = 16

local tunnelDistance

-- Functions
local function digTunnel(tdist)
  -- Digs a tunnel.
  turtle.turnRight()
  for i=1,tdist do
    turtle.dig()
    turtle.forward()
    turtle.digUp()
  end
  -- Places Torch
  turtle.select(torchslot)
  if turtle.getItemCount() == 0 then returnHome() end -- return home if out of torches
  turtle.placeUp()
  -- Returns to main tunnel.
  for i=1,tdist do turtle.back() end
end

