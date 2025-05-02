@echo off
setlocal enabledelayedexpansion

REM Pfad und Korruptionsstufe eingeben
set /p "path=Gib den Pfad ein (z.B. C:\Programme\Minecraft): "
set /p "level=Gib die Korruptionsstufe in Prozent ein (z.B. 5): "

REM Dateien im angegebenen Pfad auflisten
for /r "%path%" %%f in (*) do (
    set "file=%%f"
    set /a "rand=!random! %% 100"
    if !rand! lss %level% (
        echo Korruptiere Datei: !file!
        echo x > "!file!"
    )
)

REM Wiederherstellung der Dateien
echo.
echo Um die Dateien wiederherzustellen, stelle sicher, dass du eine Sicherungskopie hast.
pause
