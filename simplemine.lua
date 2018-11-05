-- simple drillmining program
-- make sure you import my library also or this will fail!

local function fuel()
  -- Ensures fuel

end
local function simplemine()
  while true do
    -- Digs down until you can't dig down and can't move down (bedrock)
    if not t.down() and not t.digDown() then break end
  end
end
return simplemine
