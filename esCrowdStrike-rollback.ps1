# Comprobar si se ejecuta en Modo Seguro
function Test-SafeMode {
    $regkey = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SafeBoot" -ErrorAction SilentlyContinue
    return $regkey -ne $null
}

if (-not (Test-SafeMode)) {
    Write-Host "El sistema no está en Modo Seguro. Por favor, reinicia en Modo Seguro o en el Entorno de Recuperación de Windows." -ForegroundColor Red
    exit
}

# Ruta al directorio de CrowdStrike
$directoryPath = "C:\Windows\System32\drivers\CrowdStrike"

# Verificar si el directorio existe
if (Test-Path -Path $directoryPath) {
    Write-Host "Buscando archivos que coincidan con el patrón C-00000291*.sys en $directoryPath" -ForegroundColor Cyan
    
    # Buscar y eliminar el archivo que coincide con el patrón
    $files = Get-ChildItem -Path $directoryPath -Filter "C-00000291*.sys"
    if ($files.Count -gt 0) {
        foreach ($file in $files) {
            Remove-Item -Path $file.FullName -Force
            Write-Host "Archivo eliminado: $($file.FullName)" -ForegroundColor Green
        }
    }
    else {
        Write-Host "No se encontraron archivos que coincidan con el patrón C-00000291*.sys." -ForegroundColor Yellow
    }
}
else {
    Write-Host "El directorio $directoryPath no existe." -ForegroundColor Red
}

# Reiniciar el sistema
Restart-Computer -Force
