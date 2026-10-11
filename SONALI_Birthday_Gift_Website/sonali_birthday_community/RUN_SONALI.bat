@echo off
setlocal
title SONALI Birthday Website - Local Launcher
cd /d "%~dp0"

echo.
echo  ============================================
echo    SONALI - Birthday Community Website
echo  ============================================
echo.

REM Try standard Python launchers first, then the known install location.
set "PYTHON_CMD="
where py >nul 2>nul
if %errorlevel%==0 set "PYTHON_CMD=py"

if not defined PYTHON_CMD (
    where python >nul 2>nul
    if %errorlevel%==0 set "PYTHON_CMD=python"
)

if not defined PYTHON_CMD if exist "D:\IMPORTANT\python\python.exe" set "PYTHON_CMD=D:\IMPORTANT\python\python.exe"

if not defined PYTHON_CMD (
    echo [ERROR] Python was not found in the usual locations.
    echo Please install Python 3.10 or newer, or edit this BAT file with your Python path.
    echo.
    pause
    exit /b 1
)

echo Using Python: %PYTHON_CMD%
echo.

if not exist ".venv\Scripts\python.exe" (
    echo [1/3] Creating a local Python environment...
    "%PYTHON_CMD%" -m venv .venv
    if errorlevel 1 (
        echo [ERROR] Could not create the Python environment.
        echo If this Python installation does not include venv/ensurepip, repair the Python installation.
        pause
        exit /b 1
    )
)

echo [2/3] Installing/checking required packages...
".venv\Scripts\python.exe" -m pip install --upgrade pip
if errorlevel 1 (
    echo [ERROR] pip setup failed. Check your internet connection and try again.
    pause
    exit /b 1
)
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Package installation failed. Check your internet connection.
    pause
    exit /b 1
)

echo [3/3] Starting the website...
echo.
echo Your website will open at http://127.0.0.1:5000
echo Keep this window open while testing.
echo Press Ctrl+C in this window to stop the server.
echo.

start "" "http://127.0.0.1:5000"
".venv\Scripts\python.exe" app.py
echo.
echo The server has stopped.
pause
