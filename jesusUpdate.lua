fs.delete("val_lib")
fs.delete("coords")
fs.delete("savedPositions")
fs.delete("minerJesus")
fs.delete("minerJesus.log")
fs.delete("val_lib.log")

shell.run("wget https://raw.githubusercontent.com/itsyourboychipsahoy/computercraft-api/master/dev_version/val_lib.lua val_lib")
shell.run("wget https://raw.githubusercontent.com/itsyourboychipsahoy/Random/master/minerJesus.lua minerJesus")
