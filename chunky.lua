-- Created by valvate / chips ahoy

-- Imports my library no matter the CC version!
local t
if require then
  t = require('lib')
elseif dofile then
  t = dofile('lib.lua')
else
  error('Failed to import lib.lua')
end

-- Varables --
local fuelSlot = 16
local seedsSlot = 14
local sapplingSlot
local trees = { -- Logs checked by checkTree()
  'minecraft:log',
  'minecraft:log2',
}
local function checkTree()
  -- Returns true if a tree has grown
  local _, block = turtle.inspect()
  if block.name then -- Avoid nil errors
    return(t.inTable(block.name, trees)) -- Returns true if block.name is in the "trees" table
  end
end
local function tree()
  if checkTree() == true then 
    t.saveCurrentPos('baseOfTree')
    t.dig()
    t.forward()
    while turtle.detectUp() do
      t.digUp()
      t.up()
    end
    t.gotoPos('baseOfTree')
  end
end
