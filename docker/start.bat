@echo off
rem Double-click this file on Windows. It starts the course databases in Docker.
cd /d "%~dp0"
docker info >nul 2>&1
if errorlevel 1 (
  echo Docker Desktop is not running. Start Docker Desktop first, then double-click this file again.
  pause
  exit /b 1
)
docker compose up -d --build
echo.
echo SQL Server is starting. The first start creates the databases, give it one minute.
echo Connect in SSMS or Visual Studio Code: server localhost,1433  user sa  password SqlCourse!2026
pause
