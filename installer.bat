@echo off
setlocal enabledelayedexpansion

set "TARGET_DIR=%USERPROFILE%\Downloads\Deobfuscate Files"
set "OBFUSCATED_DIR=%TARGET_DIR%\Obfuscated Code"
set "RESULTS_DIR=%TARGET_DIR%\Results"

echo ====================================================
echo             Deobfuscator Environment Setup           
echo ====================================================

echo Creating directories...
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
if not exist "%OBFUSCATED_DIR%" mkdir "%OBFUSCATED_DIR%"
if not exist "%RESULTS_DIR%" mkdir "%RESULTS_DIR%"
echo Folders created successfully at: %TARGET_DIR%

set "GITHUB_EXE_URL=https://github.com/forgbutcool/deobfuscate-testing/releases/tag/realtesting1/deobfuscator.bat"
set "OUTPUT_EXE=%TARGET_DIR%\deobfuscator.exe"

echo.
echo Fetching latest executable from GitHub...
powershell -Command "Invoke-WebRequest -Uri '%GITHUB_EXE_URL%' -OutFile '%OUTPUT_EXE%'"

if %ERRORLEVEL% EQU 0 (
    echo Successfully installed latest deobfuscator.exe!
) else (
    echo [ERROR] Failed to download file. Please check your GitHub URL or internet connection.
)

echo.
echo Setup complete. Place your obfuscated text files inside:
echo %OBFUSCATED_DIR%
echo.
pause
