# Check if running in Safe Mode
function Test-SafeMode {
    $regkey = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SafeBoot" -ErrorAction SilentlyContinue
    return $regkey -ne $null
}

if (-not (Test-SafeMode)) {
    Write-Host "The system is not in Safe Mode. Please restart in Safe Mode or in the Windows Recovery Environment." -ForegroundColor Red
    exit
}

# Path to the CrowdStrike directory
$directoryPath = "C:\Windows\System32\drivers\CrowdStrike"

# Check if the directory exists
if (Test-Path -Path $directoryPath) {
    Write-Host "Checking for files matching the pattern C-00000291*.sys in $directoryPath" -ForegroundColor Cyan
    
    # Search for and delete the file matching the pattern
    $files = Get-ChildItem -Path $directoryPath -Filter "C-00000291*.sys"
    if ($files.Count -gt 0) {
        foreach ($file in $files) {
            Remove-Item -Path $file.FullName -Force
            Write-Host "File deleted: $($file.FullName)" -ForegroundColor Green
        }
    }
    else {
        Write-Host "No files matching the pattern C-00000291*.sys were found." -ForegroundColor Yellow
    }
}
else {
    Write-Host "The directory $directoryPath does not exist." -ForegroundColor Red
}

# Restart the system
Restart-Computer -Force
