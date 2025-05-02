@echo off
setlocal enabledelayedexpansion

rem Initialisierung
set "block=#"
set "x=10"
set "y=10"
set "width=20"
set "height=10"

rem Spielfeld erstellen
for /L %%i in (1,1,%height%) do (
    for /L %%j in (1,1,%width%) do (
        set "field[%%i,%%j]= "
    )
)

:main
cls
echo Verwende 1, 2, 3 zum Wechseln der Blöcke. Aktueller Block: %block%
echo.

rem Spielfeld anzeigen
for /L %%i in (1,1,%height%) do (
    for /L %%j in (1,1,%width%) do (
        set /p "out=!field[%%i,%%j]!" <nul
    )
    echo.
)

rem Eingabe verarbeiten
set "key="
set /p "key=Eingabe: "
if "%key%"=="1" set "block=#"
if "%key%"=="2" set "block=●"
if "%key%"=="3" set "block=■"

rem Block platzieren
if "%key%"=="w" set /a "y=y-1"
if "%key%"=="s" set /a "y=y+1"
if "%key%"=="a" set /a "x=x-1"
if "%key%"=="d" set /a "x=x+1"
if "%key%"==" " set "field[%y%,%x%]=%block%"

goto main
