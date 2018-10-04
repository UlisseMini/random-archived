-- T is a table he is defined with {}
local text = 'Potatos are yummy'
local t = {
  speak = function()
    print(text)
  end

  end
  foo = function()
    print('You called foo!')
  end,
  bar = function()
    print('You called bar!')
  end,

  foobar = function()
    t.foo()
    t.bar()
  end,
  
  x = 0,
  y = 0,
  z = 0,
  xyz = function()
    print('X: '..x..' Y: '..y..' Z: '..z)
  end
}
-- you can call foo like this
t.foo()

-- you can edit table varables
t.x = 1

-- calls the xyz function
t.xyz()

-- Calls the speak functoin that reads from the text varable
t.speak()
