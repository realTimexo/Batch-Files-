@echo off
title Tetris
color 0A
mode con: cols=32 lines=20

:setup
setlocal enabledelayedexpansion
set "board=############################"
for /L %%i in (1,1,18) do set "board=!board!#                          #"
set "board=!board!############################"
set "pieces=O I S Z L J T"
set "piece=O"
set "x=14"
set "y=1"
set "speed=1000"

:game
cls
call :drawBoard
call :drawPiece
timeout /t %speed% /nobreak >nul
set /a y+=1
goto game

:drawBoard
for /L %%i in (0,1,19) do (
    set "line=!board:~%%i*32,32!"
    echo !line!
)
goto :eof

:drawPiece
rem Hier kannst du den Code hinzufügen, um das aktuelle Stück zu zeichnen
goto :eof
