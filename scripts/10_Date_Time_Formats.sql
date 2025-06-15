/* ==============================================================================
   SQL Date & Time Functions
-------------------------------------------------------------------------------
   This script shows all possible date parts, number formats, and 
   culture-specific styles available in SQL Server.
   
   Table of Contents:
     1. Number Format Specifiers
     2. Date Format Specifiers
     3. All Date Parts
     4. All Culture Formats
===============================================================================
*/

/* ==============================================================================
   NUMERIC FORMAT SPECIFIERS
===============================================================================*/

SELECT 'N' AS FormatType, FORMAT(1234.56, 'N') AS FormattedValue
UNION ALL
SELECT 'P' AS FormatType, FORMAT(1234.56, 'P') AS FormattedValue
UNION ALL
SELECT 'C' AS FormatType, FORMAT(1234.56, 'C') AS FormattedValue
UNION ALL
SELECT 'E' AS FormatType, FORMAT(1234.56, 'E') AS FormattedValue
UNION ALL
SELECT 'F' AS FormatType, FORMAT(1234.56, 'F') AS FormattedValue
UNION ALL
SELECT 'N0' AS FormatType, FORMAT(1234.56, 'N0') AS FormattedValue
UNION ALL
SELECT 'N1' AS FormatType, FORMAT(1234.56, 'N1') AS FormattedValue
UNION ALL
SELECT 'N2' AS FormatType, FORMAT(1234.56, 'N2') AS FormattedValue
UNION ALL
SELECT 'N_de-DE' AS FormatType, FORMAT(1234.56, 'N', 'de-DE') AS FormattedValue
UNION ALL
SELECT 'N_en-US' AS FormatType, FORMAT(1234.56, 'N', 'en-US') AS FormattedValue;

/* ==============================================================================
   DATE FORMAT SPECIFIERS
===============================================================================*/

SELECT 
    'D' AS FormatType, 
    FORMAT(GETDATE(), 'D') AS FormattedValue,
    'Full date pattern' AS Description
UNION ALL
SELECT 
    'd', 
    FORMAT(GETDATE(), 'd'), 
    'Short date pattern'
UNION ALL
SELECT 
    'dd', 
    FORMAT(GETDATE(), 'dd'), 
    'Day of month with leading zero'
UNION ALL
SELECT 
    'ddd', 
    FORMAT(GETDATE(), 'ddd'), 
    'Abbreviated name of day'
UNION ALL
SELECT 
    'dddd', 
    FORMAT(GETDATE(), 'dddd'), 
    'Full name of day'
UNION ALL
SELECT 
    'M', 
    FORMAT(GETDATE(), 'M'), 
    'Month without leading zero'
UNION ALL
SELECT 
    'MM', 
    FORMAT(GETDATE(), 'MM'), 
    'Month with leading zero'
UNION ALL
SELECT 
    'MMM', 
    FORMAT(GETDATE(), 'MMM'), 
    'Abbreviated name of month'
UNION ALL
SELECT 
    'MMMM', 
    FORMAT(GETDATE(), 'MMMM'), 
    'Full name of month'
UNION ALL
SELECT 
    'yy', 
    FORMAT(GETDATE(), 'yy'), 
    'Two-digit year'
UNION ALL
SELECT 
    'yyyy', 
    FORMAT(GETDATE(), 'yyyy'), 
    'Four-digit year'
UNION ALL
SELECT 
    'hh', 
    FORMAT(GETDATE(), 'hh'), 
    'Hour in 12-hour clock with leading zero'
UNION ALL
SELECT 
    'HH', 
    FORMAT(GETDATE(), 'HH'), 
    'Hour in 24-hour clock with leading zero'
UNION ALL
SELECT 
    'mm (custom)', 
    CAST(CAST(FORMAT(GETDATE(), 'm') AS INT) AS VARCHAR), 
    'Minutes without leading zero'
UNION ALL
SELECT 
    'mm', 
    FORMAT(GETDATE(), 'mm'), 
    'Minutes with leading zero'
UNION ALL
SELECT 
    's', 
    FORMAT(GETDATE(), 's'), 
    'Seconds without leading zero'
UNION ALL
SELECT 
    'ss', 
    FORMAT(GETDATE(), 'ss'), 
    'Seconds with leading zero'
UNION ALL
SELECT 
    'f', 
    FORMAT(GETDATE(), 'f'), 
    'Tenths of a second'
UNION ALL
SELECT 
    'ff', 
    FORMAT(GETDATE(), 'ff'), 
    'Hundredths of a second'
UNION ALL
SELECT 
    'fff', 
    FORMAT(GETDATE(), 'fff'), 
    'Milliseconds'
UNION ALL
SELECT 
    'T', 
    FORMAT(GETDATE(), 'T'), 
    'Full AM/PM designator'
UNION ALL
SELECT 
    't', 
    FORMAT(GETDATE(), 't'), 
    'Single character AM/PM designator'
UNION ALL
SELECT 
    'tt', 
    FORMAT(GETDATE(), 'tt'), 
    'Two character AM/PM designator';

/* ==============================================================================
   DATEPART / DATENAME / DATETRUNC COMPARISONS
===============================================================================*/

SELECT 
    'Year' AS DatePart, 
    DATEPART(year, GETDATE()) AS DatePart_Output,
    DATENAME(year, GETDATE()) AS DateName_Output,
    DATETRUNC(year, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'YY', 
    DATEPART(yy, GETDATE()) AS DatePart_Output,
    DATENAME(yy, GETDATE()) AS DateName_Output, 
    DATETRUNC(yy, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'YYYY', 
    DATEPART(yyyy, GETDATE()) AS DatePart_Output,
    DATENAME(yyyy, GETDATE()) AS DateName_Output, 
    DATETRUNC(yyyy, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Quarter', 
    DATEPART(quarter, GETDATE()) AS DatePart_Output,
    DATENAME(quarter, GETDATE()) AS DateName_Output, 
    DATETRUNC(quarter, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'QQ', 
    DATEPART(qq, GETDATE()) AS DatePart_Output,
    DATENAME(qq, GETDATE()) AS DateName_Output, 
    DATETRUNC(qq, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Q', 
    DATEPART(q, GETDATE()) AS DatePart_Output,
    DATENAME(q, GETDATE()) AS DateName_Output, 
    DATETRUNC(q, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Month', 
    DATEPART(month, GETDATE()) AS DatePart_Output,
    DATENAME(month, GETDATE()) AS DateName_Output, 
    DATETRUNC(month, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'MM', 
    DATEPART(mm, GETDATE()) AS DatePart_Output,
    DATENAME(mm, GETDATE()) AS DateName_Output, 
    DATETRUNC(mm, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'M', 
    DATEPART(m, GETDATE()) AS DatePart_Output,
    DATENAME(m, GETDATE()) AS DateName_Output, 
    DATETRUNC(m, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'DayOfYear', 
    DATEPART(dayofyear, GETDATE()) AS DatePart_Output,
    DATENAME(dayofyear, GETDATE()) AS DateName_Output, 
    DATETRUNC(dayofyear, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'DY', 
    DATEPART(dy, GETDATE()) AS DatePart_Output,
    DATENAME(dy, GETDATE()) AS DateName_Output, 
    DATETRUNC(dy, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Y', 
    DATEPART(y, GETDATE()) AS DatePart_Output,
    DATENAME(y, GETDATE()) AS DateName_Output, 
    DATETRUNC(y, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Day', 
    DATEPART(day, GETDATE()) AS DatePart_Output,
    DATENAME(day, GETDATE()) AS DateName_Output, 
    DATETRUNC(day, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'DD', 
    DATEPART(dd, GETDATE()) AS DatePart_Output,
    DATENAME(dd, GETDATE()) AS DateName_Output, 
    DATETRUNC(dd, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'D', 
    DATEPART(d, GETDATE()) AS DatePart_Output,
    DATENAME(d, GETDATE()) AS DateName_Output, 
    DATETRUNC(d, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Week', 
    DATEPART(week, GETDATE()) AS DatePart_Output,
    DATENAME(week, GETDATE()) AS DateName_Output, 
    DATETRUNC(week, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'WK', 
    DATEPART(wk, GETDATE()) AS DatePart_Output,
    DATENAME(wk, GETDATE()) AS DateName_Output, 
    DATETRUNC(wk, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'WW', 
    DATEPART(ww, GETDATE()) AS DatePart_Output,
    DATENAME(ww, GETDATE()) AS DateName_Output, 
    DATETRUNC(ww, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Weekday', 
    DATEPART(weekday, GETDATE()) AS DatePart_Output,
    DATENAME(weekday, GETDATE()) AS DateName_Output, 
    NULL AS DateTrunc_Output
UNION ALL
SELECT 
    'DW', 
    DATEPART(dw, GETDATE()) AS DatePart_Output,
    DATENAME(dw, GETDATE()) AS DateName_Output, 
    NULL AS DateTrunc_Output
UNION ALL
SELECT 
    'Hour', 
    DATEPART(hour, GETDATE()) AS DatePart_Output,
    DATENAME(hour, GETDATE()) AS DateName_Output, 
    DATETRUNC(hour, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'HH', 
    DATEPART(hh, GETDATE()) AS DatePart_Output,
    DATENAME(hh, GETDATE()) AS DateName_Output, 
    DATETRUNC(hh, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Minute', 
    DATEPART(minute, GETDATE()) AS DatePart_Output,
    DATENAME(minute, GETDATE()) AS DateName_Output, 
    DATETRUNC(minute, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'MI', 
    DATEPART(mi, GETDATE()) AS DatePart_Output,
    DATENAME(mi, GETDATE()) AS DateName_Output, 
    DATETRUNC(mi, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'N', 
    DATEPART(n, GETDATE()) AS DatePart_Output,
    DATENAME(n, GETDATE()) AS DateName_Output, 
    DATETRUNC(n, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Second', 
    DATEPART(second, GETDATE()) AS DatePart_Output,
    DATENAME(second, GETDATE()) AS DateName_Output, 
    DATETRUNC(second, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'SS', 
    DATEPART(ss, GETDATE()) AS DatePart_Output,
    DATENAME(ss, GETDATE()) AS DateName_Output, 
    DATETRUNC(ss, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'S', 
    DATEPART(s, GETDATE()) AS DatePart_Output,
    DATENAME(s, GETDATE()) AS DateName_Output, 
    DATETRUNC(s, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Millisecond', 
    DATEPART(millisecond, GETDATE()) AS DatePart_Output,
    DATENAME(millisecond, GETDATE()) AS DateName_Output, 
    DATETRUNC(millisecond, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'MS', 
    DATEPART(ms, GETDATE()) AS DatePart_Output,
    DATENAME(ms, GETDATE()) AS DateName_Output, 
    DATETRUNC(ms, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'Microsecond', 
    DATEPART(microsecond, GETDATE()) AS DatePart_Output,
    DATENAME(microsecond, GETDATE()) AS DateName_Output, 
    NULL AS DateTrunc_Output
UNION ALL
SELECT 
    'MCS', 
    DATEPART(mcs, GETDATE()) AS DatePart_Output,
    DATENAME(mcs, GETDATE()) AS DateName_Output, 
    NULL AS DateTrunc_Output
UNION ALL
SELECT 
    'Nanosecond', 
    DATEPART(nanosecond, GETDATE()) AS DatePart_Output,
    DATENAME(nanosecond, GETDATE()) AS DateName_Output, 
    NULL AS DateTrunc_Output
UNION ALL
SELECT 
    'NS', 
    DATEPART(ns, GETDATE()) AS DatePart_Output,
    DATENAME(ns, GETDATE()) AS DateName_Output, 
    NULL AS DateTrunc_Output
UNION ALL
SELECT 
    'ISOWeek', 
    DATEPART(iso_week, GETDATE()) AS DatePart_Output,
    DATENAME(iso_week, GETDATE()) AS DateName_Output, 
    DATETRUNC(iso_week, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'ISOWK', 
    DATEPART(isowk, GETDATE()) AS DatePart_Output,
    DATENAME(isowk, GETDATE()) AS DateName_Output, 
    DATETRUNC(isowk, GETDATE()) AS DateTrunc_Output
UNION ALL
SELECT 
    'ISOWW', 
    DATEPART(isoww, GETDATE()) AS DatePart_Output,
    DATENAME(isoww, GETDATE()) AS DateName_Output, 
    DATETRUNC(isoww, GETDATE()) AS DateTrunc_Output;

/* ==============================================================================
   CULTURE CODE FORMATTING USING FORMAT()
===============================================================================*/

SELECT 
    'en-US' AS CultureCode,
    FORMAT(1234567.89, 'N', 'en-US') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'en-US') AS FormattedDate
UNION ALL
SELECT 
    'en-GB' AS CultureCode,
    FORMAT(1234567.89, 'N', 'en-GB') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'en-GB') AS FormattedDate
UNION ALL
SELECT 
    'fr-FR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'fr-FR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'fr-FR') AS FormattedDate
UNION ALL
SELECT 
    'de-DE' AS CultureCode,
    FORMAT(1234567.89, 'N', 'de-DE') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'de-DE') AS FormattedDate
UNION ALL
SELECT 
    'es-ES' AS CultureCode,
    FORMAT(1234567.89, 'N', 'es-ES') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'es-ES') AS FormattedDate
UNION ALL
SELECT 
    'zh-CN' AS CultureCode,
    FORMAT(1234567.89, 'N', 'zh-CN') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'zh-CN') AS FormattedDate
UNION ALL
SELECT 
    'ja-JP' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ja-JP') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ja-JP') AS FormattedDate
UNION ALL
SELECT 
    'ko-KR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ko-KR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ko-KR') AS FormattedDate
UNION ALL
SELECT 
    'pt-BR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'pt-BR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'pt-BR') AS FormattedDate
UNION ALL
SELECT 
    'it-IT' AS CultureCode,
    FORMAT(1234567.89, 'N', 'it-IT') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'it-IT') AS FormattedDate
UNION ALL
SELECT 
    'nl-NL' AS CultureCode,
    FORMAT(1234567.89, 'N', 'nl-NL') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'nl-NL') AS FormattedDate
UNION ALL
SELECT 
    'ru-RU' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ru-RU') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ru-RU') AS FormattedDate
UNION ALL
SELECT 
    'ar-SA' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ar-SA') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ar-SA') AS FormattedDate
UNION ALL
SELECT 
    'el-GR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'el-GR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'el-GR') AS FormattedDate
UNION ALL
SELECT 
    'tr-TR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'tr-TR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'tr-TR') AS FormattedDate
UNION ALL
SELECT 
    'he-IL' AS CultureCode,
    FORMAT(1234567.89, 'N', 'he-IL') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'he-IL') AS FormattedDate
UNION ALL
SELECT 
    'hi-IN' AS CultureCode,
    FORMAT(1234567.89, 'N', 'hi-IN') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'hi-IN') AS FormattedDate;