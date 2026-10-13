# Environment Setup

SQL Server, SQL Server Management Studio and the course databases. This guide follows the Environment Setup lesson step by step. It adds what the lesson could not cover: the newer SSMS screens, Mac and Linux, and the fixes for the most common errors.

## 1. What you need

Download the course materials once. You get this folder:

```
sql-ultimate-course/
├── datasets/
│   ├── sql-server/     init-sqlserver-mydatabase.sql, init-sqlserver-salesdb.sql,
│   │                   MyDatabase.bak, SalesDB.bak
│   ├── mysql/          the same two databases for MySQL
│   ├── postgres/       the same two databases for PostgreSQL
│   └── *.csv           the five SalesDB tables as CSV files
├── docs/               the slides of every chapter as PDF
└── scripts/            every query from the course, one file per chapter
```

The course uses two databases:

| Database | Used in |
|---|---|
| `MyDatabase` | SELECT, DDL, DML, Filtering Data, Joins, String Functions, Aggregate Functions |
| `SalesDB` | everything else, from Set Operators to AI and SQL |

Every script in `scripts/` starts with a `USE` line, so it tells you which database it needs.

## 2. Windows: install SQL Server and SSMS

The course runs on SQL Server Express, the free edition. SQL Server 2022 Express is the version in the videos. SQL Server 2025 Express works too.

1. Go to the SQL Server downloads page at Microsoft, pick **Express**, and run the installer.
2. Choose the **Basic** installation. It installs an instance called `SQLEXPRESS` and makes your Windows account the administrator of it.
3. At the end, the installer shows the connection string. The server name inside it is `localhost\SQLEXPRESS`. Keep that name, you need it in a minute.
4. Download **SQL Server Management Studio** (SSMS) from the same page, or search for "download SSMS". Install it with the default options. The installer may list extra components like AI assistants or migration tools. You need none of them.

### Connect for the first time

SSMS 21 and newer look different from the video.

- At the first start, SSMS asks you to sign in with a Microsoft or GitHub account. You do not need an account. Use the skip option below the sign-in buttons.
- In the **Connect to Server** window, type the server name `localhost\SQLEXPRESS`. If the field is empty, that is normal, just type it.
- Authentication: **Windows Authentication**.
- Tick **Trust server certificate**. Newer SSMS versions encrypt every connection, and without this box you get a certificate error.
- Click **Connect**. On the left, in the Object Explorer, you see your server.

## 3. Create the databases

The lesson shows three ways. The first one is the easiest and works on every version.

### Way 1: run the scripts

1. In SSMS, click **File > Open > File** and open `datasets/sql-server/init-sqlserver-mydatabase.sql`.
2. Click **Execute** (or press F5). Refresh the Databases folder, and `MyDatabase` is there.
3. Do the same with `init-sqlserver-salesdb.sql`. Before you run it, make sure the database dropdown in the toolbar says `master`.

Use only the scripts in `sql-server/`. The scripts in `mysql/` and `postgres/` are for other database engines, and SSMS cannot run them.

### Way 2: restore the backups

1. Copy `MyDatabase.bak` and `SalesDB.bak` into the Backup folder of your SQL Server. For SQL Server 2022 Express it is:
   `C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup`
   For SQL Server 2025 the folder starts with `MSSQL17`. SQL Server cannot read your Downloads folder, so this copy step matters.
2. In the Object Explorer, right-click **Databases > Restore Database**.
3. Choose **Device**, click the three dots, click **Add**, pick the backup file, and click **OK** twice.

One rule to know: a backup restores on the same SQL Server version or a newer one, never on an older one. The course backups come from SQL Server 2022. On SQL Server 2019 or older, use way 1.

### Way 3: import the CSV files

Right-click a database, then **Tasks > Import Flat File**, and pick one of the CSV files. The lesson shows this as a demo of how to bring any CSV into SQL Server. For the course itself, use way 1 or way 2. A CSV file cannot keep the difference between an empty text and NULL, and the NULL lessons need that difference.

## 4. Mac and Linux

SQL Server does not install on macOS, and SSMS is Windows only. The way that works is Docker: SQL Server runs in a small Linux container, and you write your queries in Visual Studio Code.

### Install

1. Install **Docker Desktop** from docker.com. On a Mac, take the Apple chip version.
2. On a Mac, open the Docker Desktop settings, **General**. Set the Virtual Machine Manager to **Apple Virtualization framework** and turn on **Use Rosetta for x86_64/amd64 emulation on Apple Silicon**. SQL Server ships for Intel chips only, and this setting lets your Mac run it.
3. Install **Visual Studio Code** and, inside it, the extension **SQL Server (mssql)** by Microsoft. This is Microsoft's tool for Mac and Linux. Azure Data Studio was the old one, and Microsoft retired it in February 2026.

### Start SQL Server

Open a terminal and run one command. Choose your own password: at least 8 characters with upper case, lower case, a number and a symbol.

```
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong!Passw0rd" \
  -p 1433:1433 --name sql --platform linux/amd64 \
  -d mcr.microsoft.com/mssql/server:2022-latest
```

The first start downloads about 1.5 GB and takes a minute. After that, Docker Desktop shows a container called `sql`. Start it from there whenever you want to practice.

### Connect

In Visual Studio Code, open the SQL Server extension on the left and add a connection:

- Server: `localhost,1433`
- Authentication: **SQL Login**, user `sa`, your password
- Tick **Trust server certificate**

### Create the databases

Open `datasets/sql-server/init-sqlserver-mydatabase.sql` in Visual Studio Code and execute it against the connection. Then the same with `init-sqlserver-salesdb.sql`. That is all.

If you prefer the backup files, copy them into the container first, then restore them with a query:

```
docker cp datasets/sql-server/SalesDB.bak sql:/var/opt/mssql/SalesDB.bak
```

```sql
RESTORE DATABASE SalesDB
FROM DISK = '/var/opt/mssql/SalesDB.bak'
WITH MOVE 'SalesDB' TO '/var/opt/mssql/data/SalesDB.mdf',
     MOVE 'SalesDB_log' TO '/var/opt/mssql/data/SalesDB_log.ldf';
```

For `MyDatabase` the two names are `MyDatabase` and `MyDatabase_log`. For the analytics project, `DataWarehouseAnalytics` and `DataWarehouseAnalytics_log`.

### The projects on Docker

The two projects load CSV files with `BULK INSERT`, and the scripts point to Windows paths. Copy the datasets folder into the container, then put the container path into the script:

```
docker cp datasets sql:/var/opt/mssql/datasets
```

In the loader, a path like `C:\sql\dwh_project\datasets\source_crm\cust_info.csv` becomes `/var/opt/mssql/datasets/source_crm/cust_info.csv`.

## 5. MySQL and PostgreSQL

The course is recorded on SQL Server, and that is the engine I recommend. If you want to practice on MySQL or PostgreSQL anyway, the folders `datasets/mysql/` and `datasets/postgres/` hold the same two databases. Run them in a MySQL or PostgreSQL tool, never in SSMS.

Some things will differ. `TOP` is `LIMIT`, the date functions have other names, and the chapters on stored procedures, indexes, partitions and performance are SQL Server specific. When a query from the course fails on another engine, that is the reason, not a mistake in your setup.

## 6. The project datasets

**Data Warehouse project:** the six CSV files sit in `datasets/source_crm` and `datasets/source_erp`. The bronze loader reads them from `C:\sql\dwh_project\datasets\`, the folder used in the videos. Put the folder there, or change the six paths in `proc_load_bronze.sql`. The folder must be readable by the SQL Server service, so a folder directly on `C:\` works, and Downloads often does not.

**Data Analytics project:** restore `DataWarehouseAnalytics.bak` the same way as in section 3, or run `00_init_database.sql`, which loads the gold tables from `datasets/csv-files/`. If you built the data warehouse project, you already have the gold layer.

## 7. AdventureWorks

The index chapter uses Microsoft's sample database `AdventureWorksDW2022`. It is not part of the course materials because of its size. Get it from Microsoft: search for "AdventureWorks sample databases", open the Microsoft Learn page, and download `AdventureWorksDW2022.bak` (the data warehouse, with `FactInternetSales`). `AdventureWorks2022.bak` is the other, operational database, and it does not have that table.

Restore it like the course backups. The 2022 files need SQL Server 2022 or newer. On SQL Server 2019, take the 2019 files from the same page: the data is the same.

## 8. When something breaks

| What you see | Why | What to do |
|---|---|---|
| SSMS asks you to sign in at the first start | optional account | Use the skip option, no account needed |
| The server name field is empty | normal | Type `localhost\SQLEXPRESS` |
| Error 26, "Error Locating Server/Instance Specified" | SQL Server is not running, or the name is wrong | Open **Services**, start "SQL Server (SQLEXPRESS)". If you installed the Developer edition, the name is `localhost` without the instance |
| "The certificate chain was issued by an authority that is not trusted" | SSMS encrypts the connection | Tick **Trust server certificate** |
| Msg 262, "CREATE DATABASE permission denied in database 'master'" | your Windows login is not an administrator of this SQL Server. Someone else installed it, often IT | Log in with the Windows account that installed SQL Server, or ask an administrator to add your login to the **sysadmin** role (Security > Logins > Properties > Server Roles) |
| Msg 911, "Database 'MyDatabase' does not exist", or many syntax errors with backticks | you ran the MySQL or PostgreSQL script in SSMS | Use the scripts in `datasets/sql-server/` |
| The restore window does not show the .bak file, or "Access is denied" | SQL Server cannot read Downloads | Copy the file into the Backup folder from section 3 |
| Msg 3169, the backup "is incompatible with this server" | your SQL Server is older than 2022 | Run the scripts (way 1), or install SQL Server 2022 or 2025 Express |
| "'DATETRUNC' is not a recognized built-in function name" | SQL Server older than 2022 | Install SQL Server 2022 or newer. The course uses functions from 2022 |
| Msg 4860, "Cannot bulk load. The file does not exist or you don't have file access rights" | the path in the script is not your folder, or SQL Server cannot read it | Put the datasets folder on `C:\` and fix the path in the script |
| Installer: "Wait on the Database Engine recovery handle failed" | SQL Server could not start during setup | Uninstall SQL Server, restart Windows, install again. If it fails again, the real reason is in the ERRORLOG file under `C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Log` |
| SQL Server 2025 setup stops at the rules check | installer problem on some machines | Install SQL Server 2022 Express instead. The course runs on it |
| A .sql file opens in Notepad, or the .bak shows as text in the browser | the file is not linked to SSMS | Open SSMS first, then **File > Open > File**. For downloads, right-click the link and choose **Save link as** |
| Mac: "no matching manifest for linux/arm64" | the Intel image needs emulation | Add `--platform linux/amd64` to the command and turn on Rosetta in Docker Desktop |
| Your laptop does not let you install anything | no administrator rights | SQL Server needs them. Ask IT, or use a personal computer |

If you are still stuck, write in the Q&A with the exact error message and a screenshot of the window. Then I can see what happened.
