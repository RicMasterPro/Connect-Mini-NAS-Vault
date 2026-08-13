@echo off
title Connect: Mini NAS Vault
setlocal

set /p IP_ADDRESS="IP Address: "
set /p SHARE_NAME="Device Name: "
set "FULL_PATH=\\%IP_ADDRESS%\%SHARE_NAME%"

for /f "delims=" %%p in ('powershell -NoProfile -Command "$p = Read-Host 'Username' -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p))"') do set USERNAME=%%p

for /f "delims=" %%p in ('powershell -NoProfile -Command "$p = Read-Host 'Password' -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p))"') do set PASSWORD=%%p

net use %FULL_PATH% /user:%USERNAME% %PASSWORD%

if %errorlevel% neq 0 (
    timeout /t 3 /nobreak >nul
    exit /b %errorlevel%
)

start "" "%FULL_PATH%"

pause

net use %FULL_PATH% /delete

timeout /t 3 /nobreak >nul
exit /b 0