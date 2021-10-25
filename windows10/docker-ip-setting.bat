@echo off
setlocal enabledelayedexpansion

@REM wsl -u root service docker start | findstr "Starting Docker" > nul
@REM if !errorlevel! equ 0 (
@REM     echo docker start success
    :: set wsl2 ip
    wsl -u root ip addr | findstr "192.168.169.2" > nul
    if !errorlevel! equ 0 (
        echo wsl ip has set
    ) else (
        wsl -u root ip addr add 192.168.169.2/28 broadcast 192.168.169.15 dev eth0 label eth0:1
        echo set wsl ip success: 192.168.169.2
    )


    :: set windows ip
    ipconfig | findstr "192.168.169.1" > nul
    if !errorlevel! equ 0 (
        echo windows ip has set
    ) else (
        netsh interface ip add address "vEthernet (WSL)" 192.168.169.1 255.255.255.240
        echo set windows ip success: 192.168.169.1
    )
@REM )
pause
