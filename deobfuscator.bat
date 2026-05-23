@echo off
setlocal enabledelayedexpansion

set "TARGET_DIR=%USERPROFILE%\Downloads\Deobfuscate Files"
set "OBFUSCATED_DIR=%TARGET_DIR%\Obfuscated Code"
set "RESULTS_DIR=%TARGET_DIR%\Results"

echo ====================================================
echo             Running Code Deobfuscator                
echo ====================================================

if not exist "%OBFUSCATED_DIR%" (
    echo [ERROR] Target folder does not exist. Please run the installer first.
    pause
    exit /b
)

set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "MIN=%dt:~10,2%"
set "SEC=%dt:~12,2%"

set "AMPM=AM"
set /a "HOUR_INT=1%HH% - 100"
if %HOUR_INT% GEQ 12 (
    set "AMPM=PM"
    if %HOUR_INT% GT 12 set /a "HOUR_INT-=12"
)
if %HOUR_INT% EQU 0 set "HOUR_INT=12"
if %HOUR_INT% LSS 10 (set "FINAL_HR=0!HOUR_INT!") else (set "FINAL_HR=!HOUR_INT!")

set "TIMESTAMP=%YYYY:~2,2%-%MM%-%DD% _ !FINAL_HR!-%MIN%-%SEC% %AMPM%"

set "FILE_COUNT=0"
for %%F in ("%OBFUSCATED_DIR%\*.*") do (
    set /a "FILE_COUNT+=1"
    set "FILENAME=%%~nF"
    set "FILEEXT=%%~xF"
    
    echo Processing: !FILENAME!!FILEEXT!
    
    set "OUTPUT_FILE=%RESULTS_DIR%\!FILENAME! - %TIMESTAMP% - Deobfuscated!FILEEXT!"
    
    powershell -Command "Get-Content '%%F' | ForEach-Object { $_ -replace '\\x([0-9a-fA-F]{2})', {[char][convert]::ToInt32($_.Groups[1].Value, 16)} -replace '\\([0-9]{3})', {[char][int]$_.Groups[1].Value} } | Set-Content '!OUTPUT_FILE!'"
    
    echo Saved to: !OUTPUT_FILE!
    echo ----------------------------------------------------
)

if %FILE_COUNT% EQU 0 (
    echo No files found in the 'Obfuscated Code' folder to process.
) else (
    echo Done! Processed %FILE_COUNT% file(s).
)

pause
