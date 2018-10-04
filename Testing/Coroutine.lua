-- Coroutine testing --

listen = coroutine.create(function () 

end)
co2 = coroutine.create(function ()
    while true do
      print('Other task is still running!!')
      os.execute('sleep 1') -- bc lua has no sleep function
    end
  end)
  print('Starting read function')
coroutine.resume(co1) 
--print('Starting printing function')
--coroutine.resume(co2)
