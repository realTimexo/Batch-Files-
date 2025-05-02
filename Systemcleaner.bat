@echo off
echo.
echo [93m██████╗██╗     ███████╗██╗   ██╗███╗   ██╗██████╗ [0m
echo [93m██╔════╝██║     ██╔════╝██║   ██║████╗  ██║██╔══██╗[0m
echo [93m██║     ██║     █████╗  ██║   ██║██╔██╗ ██║██║  ██║[0m
echo [93m██║     ██║     ██╔══╝  ██║   ██║██║╚██╗██║██║  ██║[0m
echo [93m╚██████╗███████╗███████╗╚██████╔╝██║ ╚████║██████╔╝[0m
echo [93m ╚═════╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ [0m
echo.
echo [91mCleanup by Timexo[0m
echo.
echo Press 1 to delete all temporary files.
echo Press 2 to remove Cache.
echo Press 3 to clear the litter bin.
echo Press 4 to exit the program.
set /p choice=Choose an option: 

if %choice%==1 (
    echo Deleting all temporary files...
    del /q /f %temp%\*
    echo Temporary files deleted.
) else if %choice%==2 (
    echo Removing Cache...
    rd /s /q "%LocalAppData%\Microsoft\Windows\INetCache"
    echo Cache removed.
) else if %choice%==3 (
    echo Clearing the litter bin...
    rd /s /q %systemdrive%\$Recycle.Bin
    echo Litter bin cleared.
) else if %choice%==4 (
    echo Exiting the program...
    exit
) else (
    echo Invalid choice. Please run the script again and choose a valid option.
)
pause
