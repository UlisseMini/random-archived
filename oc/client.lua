-- Program from https://oc.cil.li/index.php?/topic/1087-tcp-server/
-- Modified by valvate

-- Varables --
local event = require("event")
local net = require("internet")
 
local debug_level = 3 -- Used in the log function
local data -- Used for recv function
local fileHandle -- Used in logging function

local con = net.open("ulilikespi.ddns.net", 1337)
 
-- Functions --
local function log(msg, msg_level)
	-- Defaults to 4 if msg_level is not provided
	if msg_level == nil then
		msg_level = 4
	end

	if msg_level == 4 then msg = '[DEBUG] '..msg end
	if msg_level <= debug_level then
		-- Control output from program here
		-- By default logs to a file and prints output
		print(msg)
		fileHandle = io.open('client.log', 'a')
		fileHandle.write(msg..'\n')
		fileHandle.close()
	end
end

local function send(data)
	if data == nil then data = 'nil' end
	
    log('Trying to send '..data..' data')
	con:write(data)
	con:flush()
end
 
local function recv()
	data = con:read()
	log('Type of data is '..type(data))
	con:flush()
	return data
end
local function processCommand()

end
-- Main --
 
if con then
	print('Connected to the server!')
else
	print('Failed to connect to server ):')
	error()
end
 
while true do
	local input = io.read()
	send(input)
	data = recv()
	print(data)
end
