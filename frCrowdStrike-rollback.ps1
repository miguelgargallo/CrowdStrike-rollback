# Vérifier si le système est en mode sans échec
function Test-SafeMode {
    $regkey = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SafeBoot" -ErrorAction SilentlyContinue
    return $regkey -ne $null
}

if (-not (Test-SafeMode)) {
    Write-Host "Le système n'est pas en mode sans échec. Veuillez redémarrer en mode sans échec ou dans l'environnement de récupération de Windows." -ForegroundColor Red
    exit
}

# Chemin vers le répertoire CrowdStrike
$directoryPath = "C:\Windows\System32\drivers\CrowdStrike"

# Vérifier si le répertoire existe
if (Test-Path -Path $directoryPath) {
    Write-Host "Recherche des fichiers correspondant au modèle C-00000291*.sys dans $directoryPath" -ForegroundColor Cyan
    
    # Rechercher et supprimer le fichier correspondant au modèle
    $files = Get-ChildItem -Path $directoryPath -Filter "C-00000291*.sys"
    if ($files.Count -gt 0) {
        foreach ($file in $files) {
            Remove-Item -Path $file.FullName -Force
            Write-Host "Fichier supprimé : $($file.FullName)" -ForegroundColor Green
        }
    }
    else {
        Write-Host "Aucun fichier correspondant au modèle C-00000291*.sys trouvé." -ForegroundColor Yellow
    }
}
else {
    Write-Host "Le répertoire $directoryPath n'existe pas." -ForegroundColor Red
}

# Redémarrer le système
Restart-Computer -Force
