import socket
import sys

HOST, PORT = "localhost", 82

# Create a socket (SOCK_STREAM means a TCP socket)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to server and send data
sock.connect((HOST, PORT))



sock.send("iam:user3")

while 1 == 1:
    data = raw_input('---> ')
    sock.send("msg: "+data)

#    data = sock.recv(1024)
#    print(""+data)

# Receive data from the server and shut down
#received = sock.recv(1024)
#sock.close()

#print "Sent:     %s" % data
#print "Received: %s" % received
