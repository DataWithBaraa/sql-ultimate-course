# SQL Server 2022 with the course's init scripts inside. The databases are created on the first start.
FROM mcr.microsoft.com/mssql/server:2022-latest

USER root
RUN mkdir -p /opt/sql-course/init /var/opt/mssql/sql
COPY datasets/sql-server/init-sqlserver-mydatabase.sql /opt/sql-course/init/01-mydatabase.sql
COPY datasets/sql-server/init-sqlserver-salesdb.sql    /opt/sql-course/init/02-salesdb.sql
COPY docker/entrypoint.sh /opt/sql-course/entrypoint.sh
RUN chmod +x /opt/sql-course/entrypoint.sh && chown -R mssql:root /opt/sql-course /var/opt/mssql/sql
USER mssql

ENV ACCEPT_EULA=Y
EXPOSE 1433
CMD ["/opt/sql-course/entrypoint.sh"]
