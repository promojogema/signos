@echo off
title SIGN.OS — Servidor
color 0A
cls

echo.
echo  ███████╗██╗ ██████╗ ███╗   ██╗   ██████╗ ███████╗
echo  ██╔════╝██║██╔════╝ ████╗  ██║  ██╔═══██╗██╔════╝
echo  ███████╗██║██║  ███╗██╔██╗ ██║  ██║   ██║███████╗
echo  ╚════██║██║██║   ██║██║╚██╗██║  ██║   ██║╚════██║
echo  ███████║██║╚██████╔╝██║ ╚████║  ╚██████╔╝███████║
echo  ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═════╝ ╚══════╝
echo.
echo  Sistema de Digital Signage
echo  ─────────────────────────────────────────────────
echo.

cd /d C:\signo

:: Obtener la IP local automaticamente
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "127.0.0.1"') do (
    set IP=%%a
    goto :found
)
:found
:: Quitar espacios
set IP=%IP: =%

echo  Panel disponible en:
echo.
echo    PC    ^>  http://localhost:8080/panel-control.html
echo    Movil ^>  http://%IP%:8080/panel-control.html
echo    TV    ^>  http://%IP%:8080/pantalla-tv.html
echo.
echo  ─────────────────────────────────────────────────
echo  Guarda la direccion del movil en favoritos
echo  No cierres esta ventana mientras uses el panel
echo  ─────────────────────────────────────────────────
echo.

:: Abrir el panel en Chrome automaticamente
start "" "http://localhost:8080/panel-control.html"

:: Arrancar el servidor
python -m http.server 8080

:: Si python falla, intentar con python3
if errorlevel 1 (
    echo.
    echo  Python no encontrado, intentando python3...
    python3 -m http.server 8080
)

pause
