local module = {}

function HelloWorld()
  print('Hello world!')
end
function caller()
  HelloWorld()
end
module.caller = caller
--module.HelloWorld = HelloWorld
return module
