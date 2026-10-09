@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo === NorskFlow: installasjon ===
echo.

set "PYEXE="
if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" set "PYEXE=%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
if not defined PYEXE if exist "C:\Program Files\Python312\python.exe" set "PYEXE=C:\Program Files\Python312\python.exe"

if defined PYEXE goto havepython
echo Fant ikke Python 3.12. Installerer det na via winget ...
winget install --id Python.Python.3.12 -e --scope user --silent --accept-package-agreements --accept-source-agreements
if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" set "PYEXE=%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
if not defined PYEXE goto nopython
:havepython
echo Bruker Python: %PYEXE%

if exist .venv\Scripts\python.exe goto haveenv
echo Lager eget Python-miljo ...
"%PYEXE%" -m venv .venv
if errorlevel 1 goto fail
:haveenv

set "VPY=%~dp0.venv\Scripts\python.exe"
"%VPY%" -m pip install --upgrade pip

where nvidia-smi >nul 2>nul
if errorlevel 1 goto cpu
echo.
echo Fant Nvidia-skjermkort. Installerer GPU-versjonen av PyTorch, ca 3 GB ...
"%VPY%" -m pip install torch --index-url https://download.pytorch.org/whl/cu128
goto deps
:cpu
echo.
echo Fant ikke Nvidia-skjermkort. Installerer CPU-versjonen av PyTorch ...
"%VPY%" -m pip install torch --index-url https://download.pytorch.org/whl/cpu
:deps
if errorlevel 1 goto fail

"%VPY%" -m pip install -r requirements.txt
if errorlevel 1 goto fail

echo.
echo Laster ned norsk talemodell fra Nasjonalbiblioteket ...
"%VPY%" norskflow.py --download
if errorlevel 1 goto fail

echo.
echo === Ferdig! ===
echo 1. Apne config.json og lim inn Anthropic API-nokkelen din i "anthropic_api_key".
echo 2. Dobbeltklikk 2_start.bat.
echo.
pause
exit /b 0

:nopython
echo Klarte ikke a installere Python automatisk. Installer Python 3.12 fra python.org og kjor denne filen igjen.
pause
exit /b 1

:fail
echo Noe gikk galt. Ta et skjermbilde av feilmeldingen over og vis den til Claude.
pause
exit /b 1
