-- Created by valvate / chips ahoy

-- Imports
local t
local simplemine
if require then
  t = require('lib')
  simplemine = require('simplemine')
elseif dofile then
  simplemine = dofile('simplemine.lua')
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
-- Sum functions
local function checkTree()
  -- Returns true if a tree has grown
  local _, block = turtle.inspect()
  if block.name then -- Avoid nil errors
    return(t.inTable(block.name, trees)) -- Returns true if block.name is in the "trees" table
  end
end
local function collectTree()
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
