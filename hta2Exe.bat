@echo off
setlocal EnableDelayedExpansion

:: Prüfen, ob eine Datei übergeben wurde
if "%~1"=="" (
    echo Bitte eine .hta-Datei auf diese Datei ziehen!
    pause
    exit /b
)

set "hta_file=%~1"
set "hta_name=%~nx1"
set "hta_dir=%~dp1"
set "exe_name=%hta_name:.hta=.exe%"
set "temp_dir=%TEMP%\hta2exe_tmp"

:: Temp-Ordner erstellen
if exist "%temp_dir%" rmdir /s /q "%temp_dir%"
mkdir "%temp_dir%"
copy "%hta_file%" "%temp_dir%\%hta_name%" >nul

:: SED-Datei für IExpress erstellen
set "sed_file=%temp_dir%\hta2exe.sed"
(
echo [Version]
echo Class=IEXPRESS
echo SEDVersion=3
echo [Options]
echo PackagePurpose=InstallApp
echo ShowInstallProgramWindow=0
echo HideExtractAnimation=1
echo UseLongFileName=1
echo InsideCompressed=0
echo CAB_FixedSize=0
echo CAB_ResvCodeSigning=0
echo RebootMode=N
echo InstallPrompt=
echo DisplayLicense=
echo FinishMessage=
echo TargetName=%hta_dir%%exe_name%
echo FriendlyName=HTA Wrapper
echo AppLaunched=mshta.exe %hta_name%
echo PostInstallCmd=
echo AdminQuietInstCmd=
echo UserQuietInstCmd=
echo SourceFiles=SourceFiles
echo [SourceFiles]
echo SourceFiles0=%temp_dir%
echo [SourceFiles0]
echo %hta_name%= 
) > "%sed_file%"

:: IExpress starten
iexpress /n "%sed_file%"

:: Aufräumen
rmdir /s /q "%temp_dir%"

echo.
echo Fertig! Die Datei wurde erstellt: %exe_name%
pause
