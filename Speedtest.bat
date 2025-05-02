@echo off
setlocal

:: Speedtest CLI herunterladen und entpacken
if not exist speedtest.exe (
    echo Lade Speedtest CLI herunter...
    curl -Lo speedtest.exe https://install.speedtest.net/app/cli/ookla-speedtest-1.1.1-win64.zip
    tar -xf ookla-speedtest-1.1.1-win64.zip
)

:: Internetgeschwindigkeit testen
echo Teste Internetgeschwindigkeit...
speedtest.exe --accept-license --accept-gdpr -f json > speedtest_result.json

:: Ergebnisse auslesen
for /f "tokens=2 delims=:," %%a in ('findstr /i "download bandwidth" speedtest_result.json') do set download=%%a
for /f "tokens=2 delims=:," %%a in ('findstr /i "upload bandwidth" speedtest_result.json') do set upload=%%a
for /f "tokens=2 delims=:," %%a in ('findstr /i "latency jitter" speedtest_result.json') do set ping=%%a

:: Ergebnisse anzeigen
set /a download=%download%/1000000
set /a upload=%upload%/1000000
echo Download-Geschwindigkeit: %download% Mbps
echo Upload-Geschwindigkeit: %upload% Mbps
echo Ping: %ping% ms

:: Verbindung bewerten und Verbesserungsvorschläge geben
if %download% lss 25 (
    echo Ihre Download-Geschwindigkeit ist niedrig. Versuchen Sie:
    echo - Überprüfen Sie Ihre WLAN-Verbindung.
    echo - Reduzieren Sie die Anzahl der verbundenen Geräte.
    echo - Verwenden Sie ein Ethernet-Kabel.
) else (
    echo Ihre Download-Geschwindigkeit ist gut.
)

if %upload% lss 5 (
    echo Ihre Upload-Geschwindigkeit ist niedrig. Versuchen Sie:
    echo - Überprüfen Sie Ihre WLAN-Verbindung.
    echo - Reduzieren Sie die Anzahl der verbundenen Geräte.
    echo - Verwenden Sie ein Ethernet-Kabel.
) else (
    echo Ihre Upload-Geschwindigkeit ist gut.
)

if %ping% gtr 50 (
    echo Ihr Ping ist hoch. Versuchen Sie:
    echo - Überprüfen Sie Ihre WLAN-Verbindung.
    echo - Reduzieren Sie die Anzahl der verbundenen Geräte.
    echo - Verwenden Sie ein Ethernet-Kabel.
) else (
    echo Ihr Ping ist gut.
)

endlocal
pause
