# SQL Ultimate Course

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@datawithbaraa) [![Udemy](https://img.shields.io/badge/Udemy-A435F0?style=for-the-badge&logo=udemy&logoColor=white)](https://www.udemy.com/course/the-complete-sql-bootcamp-30-hours-go-from-zero-to-hero/?referralCode=D20781228C2EB8B98339) [![Website](https://img.shields.io/badge/datawithbaraa.com-111111?style=for-the-badge&logo=googlechrome&logoColor=white)](https://www.datawithbaraa.com) [![License](https://img.shields.io/github/license/DataWithBaraa/sql-ultimate-course?style=for-the-badge&color=2EA043)](LICENSE) [![Stars](https://img.shields.io/github/stars/DataWithBaraa/sql-ultimate-course?style=for-the-badge&color=F5B301)](https://github.com/DataWithBaraa/sql-ultimate-course)

The materials of the SQL course: the databases, every query from the lessons, and the slides.

⭐ If this course helps you, star the repository so other learners can find it too.

**New here? Open the setup guide in the `00_setup` folder.** It walks you through installing SQL Server and creating the databases, on Windows and Mac, with the fixes for the common errors.

```
sql-ultimate-course/
├── 00_setup/            the setup guide, and the one-click Docker start for Mac
├── 01_datasets/         the two course databases
│   ├── 00_sql-server/   for SQL Server, the one in the videos
│   ├── 01_mysql/        the same databases for MySQL
│   ├── 02_postgres/     the same databases for PostgreSQL
│   └── 03_csv-files/    SalesDB as CSV files, for the import lesson
├── 02_docs/             the slides of every chapter, as PDF
└── 03_scripts/          every query of the course, one file per chapter
```

The course uses two databases: `MyDatabase` for the first chapters, `SalesDB` for the rest. Every script that works on a database starts with a `USE` line that names it.

<details>
<summary><b>The 41 chapters</b>: the minute in the video, the script and the slides of each one</summary>

| # | Chapter | Video | Script | Slides |
|--:|:--|:--|:--|:--|
| 1 | Intro | [0:00:00](https://youtu.be/SSKVgrwhzus?t=0) |  |  |
| 2 | Introduction to SQL | [0:07:38](https://youtu.be/SSKVgrwhzus?t=458) |  | [01_SQL_Introduction.pdf](02_docs/01_SQL_Introduction.pdf) |
| 3 | Setup Your Environment | [0:22:33](https://youtu.be/SSKVgrwhzus?t=1353) | [the setup guide](00_setup) |  |
| 4 | Query Data (SELECT) | [0:34:01](https://youtu.be/SSKVgrwhzus?t=2041) | [01_Query_Data_SELECT.sql](03_scripts/01_Query_Data_SELECT.sql) | [02_Query_Data_SELECT.pdf](02_docs/02_Query_Data_SELECT.pdf) |
| 5 | DDL Commands | [1:32:31](https://youtu.be/SSKVgrwhzus?t=5551) | [02_Data_Definition_DDL.sql](03_scripts/02_Data_Definition_DDL.sql) | [03_Data_Definition_DDL.pdf](02_docs/03_Data_Definition_DDL.pdf) |
| 6 | DML Commands | [1:43:44](https://youtu.be/SSKVgrwhzus?t=6224) | [03_Data_Manipulation_DML.sql](03_scripts/03_Data_Manipulation_DML.sql) | [04_Data_Manipulation_DML.pdf](02_docs/04_Data_Manipulation_DML.pdf) |
| 7 | Filtering Data | [2:08:03](https://youtu.be/SSKVgrwhzus?t=7683) | [04_Filtering_Data.sql](03_scripts/04_Filtering_Data.sql) | [05_Filtering_Data.pdf](02_docs/05_Filtering_Data.pdf) |
| 8 | SQL Joins (Basics) | [2:47:57](https://youtu.be/SSKVgrwhzus?t=10077) | [05_JOINs.sql](03_scripts/05_JOINs.sql) | [06_JOINS_and_SET.pdf](02_docs/06_JOINS_and_SET.pdf) |
| 9 | SQL Joins (Advanced) | [3:27:29](https://youtu.be/SSKVgrwhzus?t=12449) | [05_JOINs.sql](03_scripts/05_JOINs.sql) | [06_JOINS_and_SET.pdf](02_docs/06_JOINS_and_SET.pdf) |
| 10 | Set Operators | [4:02:09](https://youtu.be/SSKVgrwhzus?t=14529) | [06_SETs.sql](03_scripts/06_SETs.sql) | [06_JOINS_and_SET.pdf](02_docs/06_JOINS_and_SET.pdf) |
| 11 | SQL Functions | [4:47:41](https://youtu.be/SSKVgrwhzus?t=17261) |  | [07_Row_Level_Functions.pdf](02_docs/07_Row_Level_Functions.pdf) |
| 12 | String Functions | [4:52:58](https://youtu.be/SSKVgrwhzus?t=17578) | [07_String_Functions.sql](03_scripts/07_String_Functions.sql) | [07_Row_Level_Functions.pdf](02_docs/07_Row_Level_Functions.pdf) |
| 13 | Numeric Functions | [5:18:44](https://youtu.be/SSKVgrwhzus?t=19124) | [08_Number_Functions.sql](03_scripts/08_Number_Functions.sql) | [07_Row_Level_Functions.pdf](02_docs/07_Row_Level_Functions.pdf) |
| 14 | Date and Time Functions | [5:22:48](https://youtu.be/SSKVgrwhzus?t=19368) | [09_Date_Time_Functions.sql](03_scripts/09_Date_Time_Functions.sql), [10a](03_scripts/10a_Date_Time_Number_Formats.sql), [10b](03_scripts/10b_Date_Time_Date_Formats.sql), [10c](03_scripts/10c_Date_Time_Date_Parts.sql), [10d](03_scripts/10d_Date_Time_Culture_Formats.sql) | [07_Row_Level_Functions.pdf](02_docs/07_Row_Level_Functions.pdf) |
| 15 | NULL Functions | [6:59:06](https://youtu.be/SSKVgrwhzus?t=25146) | [11_NULL_Functions.sql](03_scripts/11_NULL_Functions.sql) | [07_Row_Level_Functions.pdf](02_docs/07_Row_Level_Functions.pdf) |
| 16 | Case Statement | [8:07:50](https://youtu.be/SSKVgrwhzus?t=29270) | [12_Case_Statements.sql](03_scripts/12_Case_Statements.sql) | [07_Row_Level_Functions.pdf](02_docs/07_Row_Level_Functions.pdf) |
| 17 | Aggregate Functions | [8:43:36](https://youtu.be/SSKVgrwhzus?t=31416) | [13_Aggregate_Functions.sql](03_scripts/13_Aggregate_Functions.sql) | [08_Aggregation_Analytical_Functions.pdf](02_docs/08_Aggregation_Analytical_Functions.pdf) |
| 18 | Window Functions Basics | [8:50:11](https://youtu.be/SSKVgrwhzus?t=31811) | [14_Window_Functions_Basics.sql](03_scripts/14_Window_Functions_Basics.sql) | [08_Aggregation_Analytical_Functions.pdf](02_docs/08_Aggregation_Analytical_Functions.pdf) |
| 19 | Window Aggregate | [9:47:00](https://youtu.be/SSKVgrwhzus?t=35220) | [15_Window_Aggregations.sql](03_scripts/15_Window_Aggregations.sql) | [08_Aggregation_Analytical_Functions.pdf](02_docs/08_Aggregation_Analytical_Functions.pdf) |
| 20 | Window Ranking | [10:53:09](https://youtu.be/SSKVgrwhzus?t=39189) | [16_Window_Ranking.sql](03_scripts/16_Window_Ranking.sql) | [08_Aggregation_Analytical_Functions.pdf](02_docs/08_Aggregation_Analytical_Functions.pdf) |
| 21 | Window Value | [11:56:05](https://youtu.be/SSKVgrwhzus?t=42965) | [17_Window_Value_Functions.sql](03_scripts/17_Window_Value_Functions.sql) | [08_Aggregation_Analytical_Functions.pdf](02_docs/08_Aggregation_Analytical_Functions.pdf) |
| 22 | Advanced SQL Techniques | [12:40:34](https://youtu.be/SSKVgrwhzus?t=45634) |  | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 23 | Subqueries | [12:58:04](https://youtu.be/SSKVgrwhzus?t=46684) | [18_Subqueries.sql](03_scripts/18_Subqueries.sql) | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 24 | Common Table Expressions (CTE) | [14:18:08](https://youtu.be/SSKVgrwhzus?t=51488) | [19_Common_Table_Expressions_CTE.sql](03_scripts/19_Common_Table_Expressions_CTE.sql) | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 25 | Views | [15:35:02](https://youtu.be/SSKVgrwhzus?t=56102) | [20_Views.sql](03_scripts/20_Views.sql) | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 26 | CTAS and Temp Tables | [16:36:40](https://youtu.be/SSKVgrwhzus?t=59800) | [21_Temporary_Tables.sql](03_scripts/21_Temporary_Tables.sql) | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 27 | Compare Advanced Techniques | [17:17:31](https://youtu.be/SSKVgrwhzus?t=62251) |  | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 28 | Stored Procedures | [17:27:04](https://youtu.be/SSKVgrwhzus?t=62824) | [22_Stored_Procedures.sql](03_scripts/22_Stored_Procedures.sql) | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 29 | Triggers | [18:12:58](https://youtu.be/SSKVgrwhzus?t=65578) | [23_Triggers.sql](03_scripts/23_Triggers.sql) | [09_Advanced_SQL_Techniques.pdf](02_docs/09_Advanced_SQL_Techniques.pdf) |
| 30 | Indexes | [18:23:42](https://youtu.be/SSKVgrwhzus?t=66222) | [24_Indexes.sql](03_scripts/24_Indexes.sql) | [10_Performance_Optimization.pdf](02_docs/10_Performance_Optimization.pdf) |
| 31 | Execution Plan | [20:20:31](https://youtu.be/SSKVgrwhzus?t=73231) |  | [10_Performance_Optimization.pdf](02_docs/10_Performance_Optimization.pdf) |
| 32 | Partitions | [21:11:03](https://youtu.be/SSKVgrwhzus?t=76263) | [25_Partitions.sql](03_scripts/25_Partitions.sql) | [10_Performance_Optimization.pdf](02_docs/10_Performance_Optimization.pdf) |
| 33 | 30x Performance Tips | [21:43:39](https://youtu.be/SSKVgrwhzus?t=78219) | [26_Performance_Optimization.sql](03_scripts/26_Performance_Optimization.sql) | [10_SQL_30_Performance_Tips.pdf](02_docs/10_SQL_30_Performance_Tips.pdf) |
| 34 | AI and SQL | [22:24:25](https://youtu.be/SSKVgrwhzus?t=80665) | [27_AI_and_SQL.sql](03_scripts/27_AI_and_SQL.sql) | [11_AI_and_SQL.pdf](02_docs/11_AI_and_SQL.pdf) |
| 35 | Project: SQL Data Warehouse | [23:21:04](https://youtu.be/SSKVgrwhzus?t=84064) | [the warehouse repository](https://github.com/DataWithBaraa/sql-data-warehouse-project) | [12_SQL_Projects.pdf](02_docs/12_SQL_Projects.pdf) |
| 36 | Project DWH \| Bronze | [24:32:54](https://youtu.be/SSKVgrwhzus?t=88374) | [bronze](https://github.com/DataWithBaraa/sql-data-warehouse-project/tree/main/03_scripts/bronze) | [12_SQL_Projects_ETL.pdf](02_docs/12_SQL_Projects_ETL.pdf) |
| 37 | Project DWH \| Silver | [25:10:09](https://youtu.be/SSKVgrwhzus?t=90609) | [silver](https://github.com/DataWithBaraa/sql-data-warehouse-project/tree/main/03_scripts/silver) | [12_SQL_Projects_ETL.pdf](02_docs/12_SQL_Projects_ETL.pdf) |
| 38 | Project DWH \| Gold | [26:47:46](https://youtu.be/SSKVgrwhzus?t=96466) | [gold](https://github.com/DataWithBaraa/sql-data-warehouse-project/tree/main/03_scripts/gold) | [12_SQL_Projects_ETL.pdf](02_docs/12_SQL_Projects_ETL.pdf) |
| 39 | Project: Exploratory Data Analysis (EDA) | [27:41:51](https://youtu.be/SSKVgrwhzus?t=99711) | [the analytics repository](https://github.com/DataWithBaraa/sql-data-analytics-project) | [12_SQL_Projects_Data_Analytics.pdf](02_docs/12_SQL_Projects_Data_Analytics.pdf) |
| 40 | Project: Advanced Data Analytics | [28:30:38](https://youtu.be/SSKVgrwhzus?t=102638) | [the analytics repository](https://github.com/DataWithBaraa/sql-data-analytics-project) | [12_SQL_Projects_Data_Analytics.pdf](02_docs/12_SQL_Projects_Data_Analytics.pdf) |
| 41 | Thank You | [29:47:24](https://youtu.be/SSKVgrwhzus?t=107244) |  |  |

The cheat sheet of the whole course: [SQL_Cheat_Sheet.sql](03_scripts/SQL_Cheat_Sheet.sql).

</details>

---

## 🎓 Learn with me

Watch on YouTube, or take the guided version with a certificate on my Academy or Udemy.

| Course | YouTube | My Academy | Udemy |
|:--|:--|:--|:--|
| **SQL** | [Full course](https://youtu.be/SSKVgrwhzus) · [Playlist](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZY_2eAtUzEUulNjTJREhQe) | [Full Package](https://www.datawithbaraa.com/course/sql-full-course-for-beginners) · [Handbook](https://academy.datawithbaraa.com/l/digital_download/1087406/the-sql-handbook) | [SQL Bootcamp](https://www.udemy.com/course/the-complete-sql-bootcamp-30-hours-go-from-zero-to-hero/?referralCode=D20781228C2EB8B98339) · [SQL for Analytics](https://www.udemy.com/course/sql-mastery-for-data-analytics-and-business-intelligence/) |
| **Python** | [Full course](https://youtu.be/Rq5gJVxz55Q) · [Playlist](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZGfFl2ANI_zISzNp257Lwn) | [Full Package](https://www.datawithbaraa.com/course/the-ultimate-python-mastery) · [Handbook](https://academy.datawithbaraa.com/l/digital_download/998313/the-python-handbook) | [Python Bootcamp](https://www.udemy.com/course/the-complete-python-bootcamp-13hours-go-from-zero-to-hero/?referralCode=776491A4119FF8AF41CA) |
| **Tableau** | [Full course](https://youtu.be/K3pXnbniUcM) · [Playlist](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZJqrKcUUCWCWPYCrlcVm9v) | [Full Package](https://www.datawithbaraa.com/course/tableau-ultimate-full-course-for-beginners) | [Tableau Course](https://www.udemy.com/course/the-tableau-ultimate-course-from-zero-to-hero/?referralCode=6544726FDC491A6B25EC) · [Chart Masterclass](https://www.udemy.com/course/the-tableau-ultimate-chart-masterclass-63-tableau-charts/) |
| **Power BI** | [Full course](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZge4KDGqGtqgiuVuhVZWzu) | | |
| **Databricks** | [Full course](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZWchr-GE5iPPBmOjiffK6O) | | |

Materials on my website: [SQL](https://www.datawithbaraa.com/wiki/sql) · [Python](https://www.datawithbaraa.com/wiki/python) · [Tableau](https://www.datawithbaraa.com/wiki/tableau) · [Power BI](https://www.datawithbaraa.com/wiki/power-bi)

### The SQL projects

| Project | YouTube | Materials | Udemy |
|:--|:--|:--|:--|
| **Data Warehouse** | [Watch](https://youtu.be/9GVqKuTVANE) | [Repository](https://github.com/DataWithBaraa/sql-data-warehouse-project) | [Building a Modern Data Warehouse](https://www.udemy.com/course/building-a-modern-data-warehouse-data-engineering-bootcamp/) |
| **Exploratory Data Analysis** | [Watch](https://youtu.be/6cJ5Ji8zSDg) | [Repository](https://github.com/DataWithBaraa/sql-data-analytics-project) | [SQL for Exploratory Data Analysis](https://www.udemy.com/course/sql-for-exploratory-data-analysis-eda-real-world-project/) |
| **Advanced Data Analytics** | [Watch](https://youtu.be/2jGhQpbzHes) | same repository | |

More on YouTube: [Data projects](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZ4Ym8ZriYT6WF8TaC2e_R7) · [Data careers](https://www.youtube.com/playlist?list=PLNcg_FV9n7qah95jp-aPtysu7kFCbg7hd)

## 🤝 Connect

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge)](https://www.linkedin.com/in/baraa-khatib-salkini/) [![Discord](https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/gsVJbMxKcA) [![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/datawithbaraa/) [![TikTok](https://img.shields.io/badge/TikTok-000000?style=for-the-badge&logo=tiktok&logoColor=white)](https://www.tiktok.com/@datawithbaraa) [![Newsletter](https://img.shields.io/badge/Newsletter-FF6719?style=for-the-badge&logo=substack&logoColor=white)](https://www.blog.datawithbaraa.com) [![Notion Roadmaps](https://img.shields.io/badge/Notion_Roadmaps-000000?style=for-the-badge&logo=notion&logoColor=white)](https://www.notion.com/@datawithbaraa)

## 🛡️ License

[MIT](LICENSE). Use it, change it, share it, with attribution.

## 🌟 About me

Hi, I'm **Baraa Khatib Salkini**. I spent years in enterprise data engineering and built one of the largest lakehouses at Mercedes-Benz. Today I teach data full-time at **Data With Baraa**: visually, step by step, from zero to hero.
