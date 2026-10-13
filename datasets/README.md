# Course datasets

The course uses two SQL Server databases. The Environment Setup lesson shows how to create them.

| Database | Used in | Scripts |
|---|---|---|
| `MyDatabase` | SELECT, DDL, DML, Filtering Data, Joins, String Functions, Aggregate Functions | 01 to 05, 07, 13 |
| `SalesDB` | everything else, from Set Operators to AI and SQL | 06, 09, 11, 12, 14 to 27 and the cheat sheet |

Every script in `scripts/` starts with a `USE` line, so it tells you which database it needs.

## Three ways to get the databases

1. **Run the scripts** in `sql-server/` in SQL Server Management Studio: `init-sqlserver-mydatabase.sql`, then `init-sqlserver-salesdb.sql`. This works on every SQL Server version.
2. **Restore the backups** in `sql-server/`: `MyDatabase.bak` and `SalesDB.bak`. They were made on SQL Server 2022, and a backup restores only on the same version or a newer one. On an older SQL Server, use the scripts.
3. **Import the CSV files** with "Import Flat File" in SQL Server Management Studio. The lesson shows this as a demo. A CSV file cannot keep the difference between an empty text and NULL, so for the course use way 1 or way 2.

The CSV files are the five `SalesDB` tables: `Customers.csv`, `Employees.csv`, `Products.csv`, `Orders.csv`, `OrdersArchive.csv`. They hold the same rows as the scripts and the backups.

## MySQL and PostgreSQL

`mysql/` and `postgres/` hold the same two databases for MySQL and PostgreSQL. Run them in a MySQL or PostgreSQL tool, never in SQL Server Management Studio. The course is recorded on SQL Server, so some functions and some syntax differ on other engines.

## More

The full setup steps for Windows, Mac and Linux, and the fixes for the common errors: [docs/environment_setup.md](../docs/environment_setup.md).
