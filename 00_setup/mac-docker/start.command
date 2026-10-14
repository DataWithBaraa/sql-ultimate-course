#!/bin/zsh
# Double-click this file on a Mac. It starts the course databases in Docker.
cd "$(dirname "$0")"
PATH="/Applications/Docker.app/Contents/Resources/bin:/usr/local/bin:$PATH"
if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop is not running. Start Docker Desktop first, then double-click this file again."
  read -k 1 -s "?Press any key to close."; exit 1
fi
docker compose up -d --build
echo
echo "SQL Server is starting. The first start creates the databases, give it one minute."
echo "Connect in Visual Studio Code: server localhost, port 1433, user sa, password SqlCourse!2026"
read -k 1 -s "?Press any key to close."
