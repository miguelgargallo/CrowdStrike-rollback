@echo off
setlocal

:: Funktion, um zu überprüfen, ob im abgesicherten Modus ausgeführt wird
:CheckSafeMode
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot" >nul 2>&1
if %errorlevel% neq 0 (
    echo Das System ist nicht im abgesicherten Modus. Bitte starten Sie im abgesicherten Modus oder in der Windows-Wiederherstellungsumgebung neu.
    exit /b
)

:: Pfad zum CrowdStrike-Verzeichnis festlegen
set "directoryPath=C:\Windows\System32\drivers\CrowdStrike"

:: Überprüfen, ob das Verzeichnis existiert
if exist "%directoryPath%" (
    echo Suche nach Dateien, die dem Muster C-00000291*.sys in %directoryPath% entsprechen

    :: Suchen und löschen der Dateien, die dem Muster entsprechen
    set "filesFound=0"
    for %%F in ("%directoryPath%\C-00000291*.sys") do (
        del /f "%%F" >nul 2>&1
        if %errorlevel% equ 0 (
            echo Datei gelöscht: %%F
            set "filesFound=1"
        )
    )

    :: Überprüfen, ob Dateien gelöscht wurden
    if %filesFound% equ 0 (
        echo Keine Dateien gefunden, die dem Muster C-00000291*.sys entsprechen.
    )
) else (
    echo Das Verzeichnis %directoryPath% existiert nicht.
)

:: System neu starten
shutdown /r /t 0
exit /b
