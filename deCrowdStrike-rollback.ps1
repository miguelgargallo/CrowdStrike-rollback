# Überprüfen, ob im abgesicherten Modus ausgeführt wird
function Test-SafeMode {
    $regkey = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SafeBoot" -ErrorAction SilentlyContinue
    return $regkey -ne $null
}

if (-not (Test-SafeMode)) {
    Write-Host "Das System ist nicht im abgesicherten Modus. Bitte starten Sie im abgesicherten Modus oder in der Windows-Wiederherstellungsumgebung neu." -ForegroundColor Red
    exit
}

# Pfad zum CrowdStrike-Verzeichnis
$directoryPath = "C:\Windows\System32\drivers\CrowdStrike"

# Überprüfen, ob das Verzeichnis existiert
if (Test-Path -Path $directoryPath) {
    Write-Host "Suche nach Dateien, die dem Muster C-00000291*.sys in $directoryPath entsprechen" -ForegroundColor Cyan
    
    # Suchen und löschen der Datei, die dem Muster entspricht
    $files = Get-ChildItem -Path $directoryPath -Filter "C-00000291*.sys"
    if ($files.Count -gt 0) {
        foreach ($file in $files) {
            Remove-Item -Path $file.FullName -Force
            Write-Host "Datei gelöscht: $($file.FullName)" -ForegroundColor Green
        }
    }
    else {
        Write-Host "Keine Dateien gefunden, die dem Muster C-00000291*.sys entsprechen." -ForegroundColor Yellow
    }
}
else {
    Write-Host "Das Verzeichnis $directoryPath existiert nicht." -ForegroundColor Red
}

# System neu starten
Restart-Computer -Force
