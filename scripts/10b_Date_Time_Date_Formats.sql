/* ==============================================================================
   SQL Date & Time | Date Format Specifiers
---------------------------------------------------------------------------------
   All date and time format specifiers that can be used with the FORMAT() function.
   This is the file opened in the video.
=================================================================================
*/

SELECT
    'D'                    AS FormatType,
    FORMAT(GETDATE(), 'D') AS FormattedValue,
    'Full date pattern'    AS Description
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
    'm',
    FORMAT(GETDATE(), 'm'),
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
