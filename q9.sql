SELECT fr3.plane_tail_number, 
       Avg(fr3.flight_distance / ( fr3.flight_time / 60 )) AS avg_speed 
FROM   flight_reports fr3 
WHERE  fr3.year = '2016' 
       AND fr3.month = '1' 
       AND fr3.is_cancelled = '0' 
       AND fr3.plane_tail_number IN (SELECT fr.plane_tail_number 
                                     FROM   flight_reports fr 
                                     WHERE  fr.year = '2016' 
                                            AND fr.month = '1' 
                                            AND fr.is_cancelled = '0' 
                                            AND fr.weekday_id > 5 
                                     EXCEPT 
                                     SELECT fr2.plane_tail_number 
                                     FROM   flight_reports fr2 
                                     WHERE  fr2.year = '2016' 
                                            AND fr2.month = '1' 
                                            AND fr2.is_cancelled = '0' 
                                            AND fr2.weekday_id < 6) 
GROUP  BY fr3.plane_tail_number 
ORDER  BY avg_speed DESC 