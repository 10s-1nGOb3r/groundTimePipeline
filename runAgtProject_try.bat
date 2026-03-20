@echo off
setlocal enabledelayedexpansion
title AGT Analysis Porter

:: 01. Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python was not found. Please install Python to run this tool.
    pause
    exit /b
)

:: 02. Ensure folders exist to prevent Python errors
if not exist "input_try" mkdir input_try
if not exist "output" mkdir output

:: 03. "Portable" Plugin Installer
echo [INFO] Checking for required Python libraries (pandas, numpy)...
python -m pip install --upgrade pip >nul
python -m pip install pandas numpy >nul

if %errorlevel% neq 0 (
    echo [WARNING] There was an issue installing plugins. 
    echo Please check your internet connection.
)

:: 04. Run the Script
echo.
echo [INFO] Running: agtProject_try.py
echo [INFO] Input:  .\input_try\
echo [INFO] Output: .\output\
echo ----------------------------------------------------

python agtProject_try.py

:: 05. Check for Success
if %errorlevel% equ 0 (
    echo ----------------------------------------------------
    echo [SUCCESS] Analysis complete! Check the "output" folder.
) else (
    echo ----------------------------------------------------
    echo [FAILED] The script encountered an error. 
    echo Check your input files in "input_try".
)

echo.
pause