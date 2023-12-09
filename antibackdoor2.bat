@echo off
echo Detección de permisos de administrador...

net session >nul 2>&1
if %errorLevel% == 0 (
    echo Tienes permisos de administrador.
    goto :runScript
) else (
    echo No tienes permisos de administrador. Solicitando elevación...
    powershell Start-Process -FilePath "%0" -Verb RunAs
    exit /b
)

:runScript
@echo off
setlocal enabledelayedexpansion

REM Obtener la ruta completa del archivo IPS.TXT en la carpeta del script
set "ips_file=%~dp0\ips.txt"

REM Dirección IP de redirección
set "redirect_ip=127.0.0.1"

REM Ruta del archivo hosts
set "hosts_file=%windir%\system32\drivers\etc\hosts"

REM Verificar y bloquear cada IP del archivo
for /f "tokens=*" %%i in (%ips_file%) do (
    findstr /C:"%%i" %hosts_file% > nul
    if !errorlevel! equ 0 (
        echo %%i ya está bloqueada en el archivo hosts.
    ) else (
        echo %redirect_ip% %%i >> %hosts_file%
        echo %%i bloqueada en el archivo hosts.
    )
)

REM Mensaje final
msg * "FUCK TROYANOS 20 mil IPs bloqueadas, By seba3567."

REM Agrega el comando pause al final
pause

endlocal






