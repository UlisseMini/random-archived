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

local size = tonumber(args[1])
local blocks_dug = 0 -- keeps track of dug blocks
local x,y,z = 0,0,0 -- Not using x and z yet.
local orientation = 0 -- Not being used yet.
local t = {}
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
function inList(value, list)
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
function t.dig()
	if turtle.dig() then
		blocks_dug = blocks_dug + 1
		return true
	else
		return false
	end
end

function t.digDown()
	if turtle.digDown() then
		blocks_dug = blocks_dug + 1
		return true
	else
		return false
	end
end
function t.digUp()
	if turtle.digUp() then
		blocks_dug = blocks_dug + 1
		return true
	else
		return false
	end
end

function t.up()
	if turtle.up() then
		y = y + 1
		return true
	else
		return false
	end
end
-- Made turning functions so i can add orientation later.
function t.turnLeft()
	turtle.turnLeft()
end
function t.turnRight()
	turtle.turnRight()
end
function t.turnAround()
	turtle.turnRight()
	turtle.turnRight()
end

function t.forward()
	while not turtle.forward() do
		if not t.dig() then
			log('Failed to dig block.\n Maybe i ran out of fuel then tried to move forward then failed so dug air?')
			error('Error, read quarry.log for more information.')
		end
	end
end

function t.down()
	if turtle.down() then
		y = y - 1
		return true
	else

		return false
	end
end

-- Start of program --
log('Starting quarry.')
-- All the loops!
for main=1,size do
	for line=1,size do
		while true do
			-- If you fail to dig down and fail to move down then,
			-- It must be bedrock and time to go back up.
			-- This is tricky but it will only run t.digDown if
			-- t.down fails.

			if not t.down() and not t.digDown() then
				break
			end
			
		end
		-- Going up loop
		
		-- Math.abs turns stuff like -134 to 134

		for i=1,math.abs(y) do
			if not t.up() then
				if not t.digUp() then
					log('Failed to Move and dig up! (am i out of fuel?)')
					error('Error, check quarry.log for more info')
				end
			end
		end
		-- We're now going to the next dig location.
		t.forward()
		cleanInventory() -- Drops unwanted items
	end
	-- Now we go to the next line for the turtle to dig.
	-- This could be made better but i want it to be simple
	t.turnAround()
	for i=1,size do t.forward() end
	t.turnAround()
	t.turnRight()
	t.forward()
	t.turnLeft()

end

-- Prints an ending message with how meny blocks were dug.

log('Quarry finished.\n'..tostring(blocks_dug)..' Blocks dug')