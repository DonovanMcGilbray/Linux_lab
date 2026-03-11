#!/usr/bin/env python3
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind(('0.0.0.0', 8888))
sock.listen(1)
print("Listening on port 8888")
while True:
    conn, addr = sock.accept()
    print(f"Connection from {addr}")
    conn.send(b"Hello from server\n")
    conn.close()
