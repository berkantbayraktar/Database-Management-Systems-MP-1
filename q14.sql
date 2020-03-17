SELECT res.year, 
       wd.weekday_name, 
       res.cancellation_reason AS reason, 
       res.number_of_cancellations 
FROM   weekdays wd, 
       cancellation_reasons cr, 
       ((SELECT fr.year, 
                fr.weekday_id, 
                fr.cancellation_reason, 
                Count(*) AS number_of_cancellations 
         FROM   flight_reports fr 
         WHERE  fr.is_cancelled = '1' 
         GROUP  BY fr.year, 
                   fr.weekday_id, 
                   fr.cancellation_reason 
         ORDER  BY fr.year) 
        EXCEPT 
        (SELECT DISTINCT t1.year, 
                         t1.weekday_id, 
                         t1.cancellation_reason, 
                         t1.number_of_cancellations 
         FROM   (SELECT fr.year, 
                        fr.weekday_id, 
                        fr.cancellation_reason, 
                        Count(*) AS number_of_cancellations 
                 FROM   flight_reports fr 
                 WHERE  fr.is_cancelled = '1' 
                 GROUP  BY fr.year, 
                           fr.weekday_id, 
                           fr.cancellation_reason) AS t1, 
                (SELECT fr.year, 
                        fr.weekday_id, 
                        fr.cancellation_reason, 
                        Count(*) AS number_of_cancellations 
                 FROM   flight_reports fr 
                 WHERE  fr.is_cancelled = '1' 
                 GROUP  BY fr.year, 
                           fr.weekday_id, 
                           fr.cancellation_reason) AS t2 
         WHERE  t1.year = t2.year 
                AND t1.weekday_id = t2.weekday_id 
                AND t1.number_of_cancellations < t2.number_of_cancellations)) AS 
       res 
WHERE  wd.weekday_id = res.weekday_id 
       AND cr.reason_code = res.cancellation_reason 
ORDER  BY res.year, wd.weekday_id