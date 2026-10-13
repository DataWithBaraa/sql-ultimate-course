/* ==============================================================================
   SQL Date & Time | Culture Formats
---------------------------------------------------------------------------------
   All culture codes that can be used with the FORMAT() function,
   with a number and a date example each.
   This is the file opened in the video.
=================================================================================
*/

-- All culture codes can be used in FORMAT SQL Function
SELECT 'en-US' AS CultureCode,
       FORMAT(1234567.89, 'N', 'en-US') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'en-US')  AS FormattedDate
UNION ALL
SELECT 'en-GB' AS CultureCode,
       FORMAT(1234567.89, 'N', 'en-GB') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'en-GB')  AS FormattedDate
UNION ALL
SELECT 'fr-FR' AS CultureCode,
       FORMAT(1234567.89, 'N', 'fr-FR') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'fr-FR')  AS FormattedDate
UNION ALL
SELECT 'de-DE' AS CultureCode,
       FORMAT(1234567.89, 'N', 'de-DE') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'de-DE')  AS FormattedDate
UNION ALL
SELECT 'es-ES' AS CultureCode,
       FORMAT(1234567.89, 'N', 'es-ES') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'es-ES')  AS FormattedDate
UNION ALL
SELECT 'zh-CN' AS CultureCode,
       FORMAT(1234567.89, 'N', 'zh-CN') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'zh-CN')  AS FormattedDate
UNION ALL
SELECT 'ja-JP' AS CultureCode,
       FORMAT(1234567.89, 'N', 'ja-JP') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'ja-JP')  AS FormattedDate
UNION ALL
SELECT 'ko-KR' AS CultureCode,
       FORMAT(1234567.89, 'N', 'ko-KR') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'ko-KR')  AS FormattedDate
UNION ALL
SELECT 'pt-BR' AS CultureCode,
       FORMAT(1234567.89, 'N', 'pt-BR') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'pt-BR')  AS FormattedDate
UNION ALL
SELECT 'it-IT' AS CultureCode,
       FORMAT(1234567.89, 'N', 'it-IT') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'it-IT')  AS FormattedDate
UNION ALL
SELECT 'nl-NL' AS CultureCode,
       FORMAT(1234567.89, 'N', 'nl-NL') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'nl-NL')  AS FormattedDate
UNION ALL
SELECT 'ru-RU' AS CultureCode,
       FORMAT(1234567.89, 'N', 'ru-RU') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'ru-RU')  AS FormattedDate
UNION ALL
SELECT 'ar-SA' AS CultureCode,
       FORMAT(1234567.89, 'N', 'ar-SA') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'ar-SA')  AS FormattedDate
UNION ALL
SELECT 'el-GR' AS CultureCode,
       FORMAT(1234567.89, 'N', 'el-GR') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'el-GR')  AS FormattedDate
UNION ALL
SELECT 'tr-TR' AS CultureCode,
       FORMAT(1234567.89, 'N', 'tr-TR') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'tr-TR')  AS FormattedDate
UNION ALL
SELECT 'he-IL' AS CultureCode,
       FORMAT(1234567.89, 'N', 'he-IL') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'he-IL')  AS FormattedDate
UNION ALL
SELECT 'hi-IN' AS CultureCode,
       FORMAT(1234567.89, 'N', 'hi-IN') AS FormattedNumber,
       FORMAT(GETDATE(), 'D', 'hi-IN')  AS FormattedDate;
