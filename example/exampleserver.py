import socket # Imports the socket library so we can use it

port = 1337 # Port for the socket to listen on
address = '' # blank means accept connections from everywhere

# Socket is a class so we need an instance of that class
s = socket.socket() # Using default (raw tcp)

# Binds the socket to a port
s.bind((address, port))

# Starts the listener
s.listen(1) # one is the amount of connections to allow

# Accept connections
c, client = s.accept() # Returns the open socket connection (c) and the connected computers ip and port in a list
# Once a client connects do this
# Sends a welcome message

welcomeMsg = "Welcome to example server {}!\n".format(client[0]) # \n = newline
c.sendall(welcomeMsg.encode()) # .encode() encodes in into byte format so it can be sent.
# Prompt that will be repeated in the while loop
prompt = "> "
# Encodes prompt to bytes for easy sending
prompt = prompt.encode()
# Prints info about connected device
print("%s Connected" % (client[0])) # Prints the connectors ip
print("I will be printing all data received.")

while True:
    c.sendall(prompt)
    data = c.recv(1024) # 1024 is the buffer, in this case any data after 1024 in one packet will be droped.
    print(data.decode()) # Decodes data from bytes and prints to the screen
    c.sendall("Got {}".format(data.decode()).encode()) # Messy af, just prints got + data received
