@echo off
setlocal

:: Function to check if running in Safe Mode
:CheckSafeMode
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system is not in Safe Mode. Please restart in Safe Mode or in the Windows Recovery Environment.
    exit /b
)

:: Set the path to the CrowdStrike directory
set "directoryPath=C:\Windows\System32\drivers\CrowdStrike"

:: Check if the directory exists
if exist "%directoryPath%" (
    echo Checking for files matching the pattern C-00000291*.sys in %directoryPath%

    :: Search for and delete the files matching the pattern
    set "filesFound=0"
    for %%F in ("%directoryPath%\C-00000291*.sys") do (
        del /f "%%F" >nul 2>&1
        if %errorlevel% equ 0 (
            echo File deleted: %%F
            set "filesFound=1"
        )
    )

    :: Check if any files were deleted
    if %filesFound% equ 0 (
        echo No files matching the pattern C-00000291*.sys were found.
    )
) else (
    echo The directory %directoryPath% does not exist.
)

:: Restart the system
shutdown /r /t 0
exit /b
