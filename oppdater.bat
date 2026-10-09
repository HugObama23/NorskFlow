@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Stopper NorskFlow hvis den kjorer ...
powershell -NoProfile -Command "Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like '*norskflow.py*' -and $_.Name -like 'python*' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }"
echo Installerer nye pakker ...
"%~dp0.venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto fail
echo Starter NorskFlow ...
start "" "%~dp0.venv\Scripts\pythonw.exe" "%~dp0norskflow.py"
echo Ferdig. Se etter mikrofonikonet ved klokka.
timeout /t 4 >nul
exit /b 0
:fail
echo Noe gikk galt. Ta et skjermbilde og vis det til Claude.
pause
exit /b 1
