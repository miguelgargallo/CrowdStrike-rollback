@echo off
setlocal

:: Fonction pour vérifier si le système est en mode sans échec
:CheckSafeMode
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot" >nul 2>&1
if %errorlevel% neq 0 (
    echo Le système n'est pas en mode sans échec. Veuillez redémarrer en mode sans échec ou dans l'environnement de récupération de Windows.
    exit /b
)

:: Définir le chemin vers le répertoire CrowdStrike
set "directoryPath=C:\Windows\System32\drivers\CrowdStrike"

:: Vérifier si le répertoire existe
if exist "%directoryPath%" (
    echo Recherche des fichiers correspondant au modèle C-00000291*.sys dans %directoryPath%

    :: Rechercher et supprimer les fichiers correspondant au modèle
    set "filesFound=0"
    for %%F in ("%directoryPath%\C-00000291*.sys") do (
        del /f "%%F" >nul 2>&1
        if %errorlevel% equ 0 (
            echo Fichier supprimé : %%F
            set "filesFound=1"
        )
    )

    :: Vérifier si des fichiers ont été supprimés
    if %filesFound% equ 0 (
        echo Aucun fichier correspondant au modèle C-00000291*.sys trouvé.
    )
) else (
    echo Le répertoire %directoryPath% n'existe pas.
)

:: Redémarrer le système
shutdown /r /t 0
exit /b
