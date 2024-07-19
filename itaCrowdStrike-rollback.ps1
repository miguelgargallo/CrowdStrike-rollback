# Verificare se è in modalità provvisoria
function Test-SafeMode {
    $regkey = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SafeBoot" -ErrorAction SilentlyContinue
    return $regkey -ne $null
}

if (-not (Test-SafeMode)) {
    Write-Host "Il sistema non è in modalità provvisoria. Per favore, riavvia in modalità provvisoria o nell'ambiente di ripristino di Windows." -ForegroundColor Red
    exit
}

# Percorso alla directory di CrowdStrike
$directoryPath = "C:\Windows\System32\drivers\CrowdStrike"

# Verificare se la directory esiste
if (Test-Path -Path $directoryPath) {
    Write-Host "Ricerca dei file che corrispondono al modello C-00000291*.sys in $directoryPath" -ForegroundColor Cyan
    
    # Cercare e eliminare il file che corrisponde al modello
    $files = Get-ChildItem -Path $directoryPath -Filter "C-00000291*.sys"
    if ($files.Count -gt 0) {
        foreach ($file in $files) {
            Remove-Item -Path $file.FullName -Force
            Write-Host "File eliminato: $($file.FullName)" -ForegroundColor Green
        }
    }
    else {
        Write-Host "Nessun file che corrisponde al modello C-00000291*.sys trovato." -ForegroundColor Yellow
    }
}
else {
    Write-Host "La directory $directoryPath non esiste." -ForegroundColor Red
}

# Riavviare il sistema
Restart-Computer -Force
