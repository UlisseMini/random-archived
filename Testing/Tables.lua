-- Testing tables :D

table1 = {
	['a'] = function() print('Hello you just called the a function') end,
	['b'] = 'My value is b and that is my name too!',
	[21] = function() print('I\'m a number but still a function!') end
 
}
print('Calling function a')
table1['a']()
print('Calling a again')
table1.a()
print(table1[b])
print('Trying to call the number function...')
--table1[21]()
