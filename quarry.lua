-- Simple quarry program by valvate.
-- Could be made much better but i'm lazy ¯\_(ツ)_/¯

-- TODO: add orienation and cords
-- TODO: Make a library with all the move functions
-- So i can import them easily.

-- Also, i use log('Error message here') then error('Check quarry.log') because
-- I'm afraid of the error message going outside the turtles screen and not being able to read it.

local args = { ... }

if #args ~= 1 then
	print('Usage: quarry <Size>')
	error()
end
local t = require('lib')

local size = tonumber(args[1])

-- List of items that the cleanInventory function will throw away.
local unWantedItems = {
	'minecraft:cobblestone',
	'minecraft:stone',
	'minecraft:gravel',
	'minecraft:dirt',
	'minecraft:flint',
	'minecraft:sandstone',
	'minecraft:sand'

}

local function log(msg)
	print(msg)
	local file_handle = fs.open('quarry.log', 'a')
	file_handle.write(msg..'\n') -- Adds newline after message
	file_handle.close()
end

local function inList(value, list)
	for i=1,#list do
		if value == list[i] then
			return true
		end
	end
	return false
end

function cleanInventory()
	local item
	local prevSlot = turtle.getSelectedSlot()

	for i=1,16 do
		item = turtle.getItemDetail(i)
		if item and inList(item.name, unWantedItems) then
			turtle.select(i)
			turtle.dropDown(item.count) -- drops everything
		end
		turtle.select(prevSlot) -- Leave no trace!
	end
end

function t.turnAround()
	t.turnRight()
	t.turnRight()
end

function forward()
	while not t.forward() do
		if not t.dig() then
			log('Failed to dig block.\n Maybe i ran out of fuel then tried to move forward then failed so dug air?')
			error('Error, read quarry.log for more information.')
		end
	end
end

-- Start of program --
log('Starting quarry.')
t.saveCurrentPos('start')

-- All the loops!
for main=1,size do
	for line=1,size do
		t.saveCurrentPos('top')
		while true do
			-- If you fail to dig down and fail to move down then,
			-- It must be bedrock and time to go back up.
			-- This is tricky but it will only run t.digDown if
			-- t.down fails.

			if not t.down() and not t.digDown() then
				break
			end
			
		end
		-- Going up
		t.gotoPos('top')

		-- We're now going to the next dig location.
		forward()
		cleanInventory() -- Drops unwanted items
	end
	-- Goes to the next line.
	t.goto(main, 0, 0, 0)
end

t.savePosisionsToFile()
-- Prints an ending message with how meny blocks were dug.
log('Quarry finished.\n'..tostring(t.blocks_dug)..' Blocks dug')
