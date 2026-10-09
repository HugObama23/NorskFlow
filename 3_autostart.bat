@echo off
chcp 65001 >nul
cd /d "%~dp0"
powershell -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('Startup')+'\NorskFlow.lnk'); $s.TargetPath='%~dp0.venv\Scripts\pythonw.exe'; $s.Arguments='\"%~dp0norskflow.py\"'; $s.WorkingDirectory='%~dp0'; $s.Save()"
echo NorskFlow starter na automatisk nar du logger inn pa Windows.
echo For a skru det av: trykk Win+R, skriv shell:startup og slett NorskFlow.
pause
