@echo off
setlocal EnableExtensions

title Win Defender Update - Defender Installer

echo ==========================================
echo        Win Defender Update
echo        Defender Installer
echo ==========================================
echo.

echo Checking Microsoft Defender...
echo.

sc query WinDefend >nul 2>&1

if %errorlevel%==0 (
    echo [OK] Microsoft Defender service was found.
    echo.
    echo Defender is already installed or available.
    echo No installation is required.
    echo.
    pause
    exit /b 0
)

echo [WARNING] Microsoft Defender was not detected.
echo.
echo Would you like to open the official Windows
echo security components so Defender can be restored?
echo.
echo [Y] Yes
echo [N] No
echo.

choice /C YN /N /M "Your choice: "

if errorlevel 2 (
    echo.
    echo Installation cancelled.
    pause
    exit /b 0
)

echo.
echo Opening Windows Security...
echo.

start "" "windowsdefender:"

if %errorlevel% neq 0 (
    echo.
    echo Windows Security could not be opened.
    echo Please restore Microsoft Defender using
    echo the official Windows installation or recovery tools.
    echo.
    pause
    exit /b 1
)

echo.
echo Windows Security has been opened.
echo Follow the instructions provided by Windows.
echo.
pause

endlocal