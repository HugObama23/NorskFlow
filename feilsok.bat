@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo NorskFlow i feilsokingsmodus. Feilmeldinger vises her. Lukk vinduet for a stoppe.
"%~dp0.venv\Scripts\python.exe" "%~dp0norskflow.py"
pause
