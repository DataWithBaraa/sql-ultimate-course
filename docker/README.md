# The course databases in one command

SQL Server 2022 in Docker, with `MyDatabase` and `SalesDB` created from the course's own init scripts on the first start. Works the same on Mac, Linux and Windows.

1. Install **Docker Desktop** from docker.com and start it. On a Mac with an Apple chip, turn on **Use Rosetta for x86_64/amd64 emulation** in the Docker Desktop settings, under General.
2. Double-click `start.command` (Mac) or `start.bat` (Windows). On Linux, run `docker compose up -d --build` in this folder. The first start downloads SQL Server, about 1.5 GB, and creates the databases.
3. Connect from Visual Studio Code with the **SQL Server (mssql)** extension, or from SSMS on Windows: server name `localhost`, port `1433` (in SSMS: `localhost,1433`), tick **Trust server certificate**, SQL Login, user `sa`, password `SqlCourse!2026`.

## The projects

If the two project folders sit next to this repository, like this:

```
sql-course/
├── sql-ultimate-course/
├── sql-data-warehouse-project/
└── sql-data-analytics-project/
```

then they are visible inside the container under `/var/opt/mssql/sql/`, the same layout as `C:\sql\` in the videos, and the `DataWarehouseAnalytics` database is created too. In the project scripts, replace `C:\sql\` with `/var/opt/mssql/sql/` and the backslashes with slashes. For example `C:\sql\dwh_project\datasets\source_crm\cust_info.csv` becomes `/var/opt/mssql/sql/dwh_project/datasets/source_crm/cust_info.csv`.

## Good to know

- Stop with `docker compose down`. Your data stays in a Docker volume. `docker compose down -v` deletes it, and the next start creates the databases again from the scripts.
- To start from a clean database, run `docker compose down -v` and start again.
- The password is only for your own computer. Change it in `docker-compose.yml` if you want another one.
