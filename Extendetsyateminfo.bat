@echo off
echo Systeminformationen
echo =====================
echo.
echo CPU-Auslastung:
wmic cpu get loadpercentage
echo.
echo Speicherplatz:
wmic logicaldisk get size,freespace,caption
echo.
echo RAM-Benutzung:
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
echo.
echo Grafikkarten-Benutzung:
wmic path win32_videocontroller get name,adapterram
echo.
echo Installierte Software:
wmic product get name,version
echo.
echo Komponenten:
wmic baseboard get product,manufacturer
wmic cpu get name
wmic diskdrive get model
wmic memorychip get manufacturer,capacity
wmic path win32_videocontroller get name
echo.
pause
