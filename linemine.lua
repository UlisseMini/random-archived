-- LineMiner --
-- Args --
args = { ... }
if #args ~= 1 then
	print('Usage: linemine <distance>')
end
-- Varables --
local distance = args[1]
local trashblocks = {
	'minecraft:stone',
	'minecraft:dirt',
	'minecraft:grass',
	'minecraft:gravel'
}
local use_rednet = true
local debug_level = 3 -- 4 = debug 3 = info 2 = warning 1 = error
-- Functions --
local function checkFuel()
	if turtle.getFuelLevel() <= distance*2 then
		print('You need more fuel!')
		error()
	end
end
local function log(msg, msg_debug_level)
	if msg_debug_level <= debug_level then
		print(msg)
		if use_rednet == true then
			rednet.broadcast(msg)
		end
	end
end

local function isTrash(block)
	-- This function returns true if a block is trash and false otherwise
	for i=1,#trashblocks do
		if trashblocks[i] == block then
			return true
		end
	end
	return false
end

local function processblocks()
	local _, blockup = turtle.inspectUp()
	local _, blockdown = turtle.inspectDown()
	if isTrash(blockup.name) == false then
		log('[INFO] Found '..blockup.name, 3)
		turtle.digUp()
	end
	if isTrash(blockdown.name) == false then
		log('[INFO] Found '..blockdown.name, 3)
		turtle.digDown()
	end
end

-- Main program --

for i=1,distance do
	turtle.dig()
	processblocks()
	turtle.forward()
end
-- Returns home
for i=1,distance do
	turtle.back()
end