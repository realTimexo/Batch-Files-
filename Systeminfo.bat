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
echo Installierte Software:
wmic product get name,version
echo.
pause
