#!/bin/bash
# Start SQL Server. On the first start, create the course databases from the init scripts,
# and the analytics database when the analytics project folder is mounted.
/opt/mssql/bin/sqlservr &
PID=$!
SQLCMD=/opt/mssql-tools18/bin/sqlcmd
MARK=/var/opt/mssql/data/.sql-course-ready
ANALYTICS=/var/opt/mssql/sql/sql-data-analytics-project
run() { "$SQLCMD" -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -b -i "$1" || echo "sql-course: $(basename "$1") reported an error"; }
if [ ! -f "$MARK" ]; then
  for i in $(seq 1 120); do
    sleep 2
    "$SQLCMD" -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SELECT 1" >/dev/null 2>&1 && break
  done
  echo "sql-course: creating MyDatabase";  run /opt/sql-course/init/01-mydatabase.sql
  echo "sql-course: creating SalesDB";     run /opt/sql-course/init/02-salesdb.sql
  if [ -f "$ANALYTICS/scripts/00_init_database.sql" ] && [ -f "$ANALYTICS/datasets/csv-files/gold.fact_sales.csv" ]; then
    echo "sql-course: creating DataWarehouseAnalytics from the analytics project folder"
    sed 's#C:\\sql\\sql-data-analytics-project\\datasets\\csv-files\\#/var/opt/mssql/sql/sql-data-analytics-project/datasets/csv-files/#g' \
      "$ANALYTICS/scripts/00_init_database.sql" > /tmp/analytics-init.sql
    run /tmp/analytics-init.sql
  else
    echo "sql-course: analytics project folder not found next to this repository, DataWarehouseAnalytics skipped"
  fi
  touch "$MARK"
  echo "sql-course: ready. Connect to localhost,1433 as sa"
fi
wait $PID
