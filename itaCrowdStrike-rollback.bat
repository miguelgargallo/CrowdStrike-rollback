@echo off
setlocal

:: Funzione per verificare se è in modalità provvisoria
:CheckSafeMode
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot" >nul 2>&1
if %errorlevel% neq 0 (
    echo Il sistema non è in modalità provvisoria. Per favore, riavvia in modalità provvisoria o nell'ambiente di ripristino di Windows.
    exit /b
)

:: Impostare il percorso alla directory di CrowdStrike
set "directoryPath=C:\Windows\System32\drivers\CrowdStrike"

:: Verificare se la directory esiste
if exist "%directoryPath%" (
    echo Ricerca dei file che corrispondono al modello C-00000291*.sys in %directoryPath%

    :: Cercare e eliminare i file che corrispondono al modello
    set "filesFound=0"
    for %%F in ("%directoryPath%\C-00000291*.sys") do (
        del /f "%%F" >nul 2>&1
        if %errorlevel% equ 0 (
            echo File eliminato: %%F
            set "filesFound=1"
        )
    )

    :: Verificare se i file sono stati eliminati
    if %filesFound% equ 0 (
        echo Nessun file che corrisponde al modello C-00000291*.sys trovato.
    )
) else (
    echo La directory %directoryPath% non esiste.
)

:: Riavviare il sistema
shutdown /r /t 0
exit /b
