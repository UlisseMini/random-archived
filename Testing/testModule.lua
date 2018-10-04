local m = {}
print('Setting testvar to 1')
local testvar = 1

local function foo()
  print('Hello world!')
  print('Testvar is equal to '..testvar)
  testvar = testvar + 1
end
m.foo = foo
return m
