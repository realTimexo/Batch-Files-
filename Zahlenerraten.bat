@echo off
title Zahlenraten Spiel
color 0a
set /a zufallszahl=%RANDOM% %% 100 + 1
set /a versuche=0

:anfang
cls
set /p "eingabe=Rate eine Zahl zwischen 1 und 100: "
set /a versuche+=1

if %eingabe%==%zufallszahl% (
    echo Glückwunsch! Du hast die Zahl %zufallszahl% in %versuche% Versuchen erraten.
    pause
    exit
) else if %eingabe% GTR %zufallszahl% (
    echo Die gesuchte Zahl ist kleiner.
) else (
    echo Die gesuchte Zahl ist größer.
)

goto anfang
