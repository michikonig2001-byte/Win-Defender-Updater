@echo off
setlocal EnableExtensions
title Win Defender Update - Defender Installer

:START
cls
echo ==========================================
echo          WIN DEFENDER UPDATE
echo             DEF INSTALLER
echo ==========================================
echo.
echo This wizard will configure Defender.
echo.

:: STEP 1 - LANGUAGE
:LANGUAGE
echo [1/4] Select language:
echo.
echo 1. English
echo 2. Russian
echo.
choice /C 12 /N /M "Select: "

if errorlevel 2 goto RUSSIAN
if errorlevel 1 goto ENGLISH

:ENGLISH
set "LANG=EN"
goto FEATURES

:RUSSIAN
set "LANG=RU"
goto FEATURES


:: STEP 2 - FEATURES
:FEATURES
cls
echo ==========================================
echo [2/4] DEFENDER FEATURES
echo ==========================================
echo.
echo Select the features you want to use:
echo.
echo 1. Real-time protection
echo 2. Cloud protection
echo 3. Automatic security updates
echo 4. Periodic scanning
echo.
echo These settings will be handled by
echo Microsoft Defender / Windows Security.
echo.
pause


:: STEP 3 - WINDOWS VERSION
:WINDOWS
cls
echo ==========================================
echo [3/4] WINDOWS VERSION
echo ==========================================
echo.

ver

for /f "tokens=4-5 delims=. " %%A in ('ver') do (
    set "WINVER=%%A"
)

echo.
echo Windows version detected.
echo.

pause


:: STEP 4 - PERMISSIONS
:PERMISSIONS
cls
echo ==========================================
echo [4/4] PERMISSIONS
echo ==========================================
echo.
echo Win Defender Update may require
echo administrator privileges for some
echo Defender operations.
echo.
echo Do you allow this installer to continue?
echo.
echo [Y] Yes
echo [N] No
echo.

choice /C YN /N /M "Your choice: "

if errorlevel 2 goto CANCEL
if errorlevel 1 goto INSTALL


:: INSTALL
:INSTALL
cls
echo ==========================================
echo           DEFENDER INSTALLER
echo ==========================================
echo.
echo Checking Microsoft Defender...
echo.

sc query WinDefend >nul 2>&1

if %errorlevel%==0 (
    echo [OK] Microsoft Defender service detected.
    echo.
    echo Defender is already available.
    echo No installation is required.
    echo.
    echo Opening Windows Security...
    start "" "windowsdefender:"
    goto FINISH
)

echo [WARNING] Microsoft Defender was not detected.
echo.
echo This installer will NOT download Defender
echo from an unknown website.
echo.
echo Please use the official Windows recovery
echo or installation mechanisms to restore it.
echo.

start "" "windowsdefender:"

goto FINISH


:CANCEL
cls
echo ==========================================
echo             CANCELLED
echo ==========================================
echo.
echo Installation was cancelled by the user.
echo.
pause
exit /b 0


:FINISH
echo.
echo ==========================================
echo              FINISHED
echo ==========================================
echo.
echo Win Defender Update has finished this step.
echo.
pause
exit /b 0