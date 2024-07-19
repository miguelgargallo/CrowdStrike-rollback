@echo off
setlocal

:: Función para comprobar si se ejecuta en Modo Seguro
:CheckSafeMode
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot" >nul 2>&1
if %errorlevel% neq 0 (
    echo El sistema no está en Modo Seguro. Por favor, reinicia en Modo Seguro o en el Entorno de Recuperación de Windows.
    exit /b
)

:: Establecer la ruta al directorio de CrowdStrike
set "directoryPath=C:\Windows\System32\drivers\CrowdStrike"

:: Comprobar si el directorio existe
if exist "%directoryPath%" (
    echo Buscando archivos que coincidan con el patrón C-00000291*.sys en %directoryPath%

    :: Buscar y eliminar los archivos que coincidan con el patrón
    set "filesFound=0"
    for %%F in ("%directoryPath%\C-00000291*.sys") do (
        del /f "%%F" >nul 2>&1
        if %errorlevel% equ 0 (
            echo Archivo eliminado: %%F
            set "filesFound=1"
        )
    )

    :: Comprobar si se eliminaron archivos
    if %filesFound% equ 0 (
        echo No se encontraron archivos que coincidan con el patrón C-00000291*.sys.
    )
) else (
    echo El directorio %directoryPath% no existe.
)

:: Reiniciar el sistema
shutdown /r /t 0
exit /b
