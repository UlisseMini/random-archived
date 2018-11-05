#!/usr/bin/python3
# Server for communication to OC client control computer
# TODO: Add cocurrent reading user input for sending and receiving data

import socket

port = 1337
addr = '' # Later i should change this to switchcrafts ip so that i only get connections from there
s = socket.socket() # Defaults to tcp

debug_level = 3 # Debug level to display
logfile = 'server.log' # Change this if you want
debug = True # Change this if you're debuging

# Bind the socket
s.bind((addr, port))

# Listen for connections
s.listen(1)

# Accept connections
c, client = s.accept()
print('Connection from {}:{}'.format(client[0], client[1])) # Prints the connected ip and port

# Some functions
def log(msg, msg_debug=4): # Default to message level 4 (debug)
    if debug_level >= msg_debug:
        print(msg)

    if debug == True: # Logs all messages (for debuging)
        fileHandle = open(logfile, 'a') # Append mode
        fileHandle.write(msg + '\n') # Write message with a newline after it
        fileHandle.close()


while True:
    data = c.recv(1024)
    log(data.decode())
