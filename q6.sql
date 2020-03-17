SELECT fr.weekday_id, 
       w2.weekday_name, 
       Avg(fr.arrival_delay) AS avg_delay 
FROM   flight_reports fr, 
       weekdays w2 
WHERE  fr.weekday_id = w2.weekday_id 
       AND fr.origin_city_name = 'San Francisco, CA' 
       AND fr.dest_city_name = 'Boston, MA' 
GROUP  BY fr.weekday_id, 
          w2.weekday_name 
HAVING Avg(fr.arrival_delay) <= ALL (SELECT Avg(fr.arrival_delay) 
                                     FROM   flight_reports fr, 
                                            weekdays w2 
                                     WHERE  fr.weekday_id = w2.weekday_id 
                                            AND 
              fr.origin_city_name = 'San Francisco, CA' 
                                            AND fr.dest_city_name = 'Boston, MA' 
                                     GROUP  BY fr.weekday_id, 
                                               w2.weekday_name) 