SELECT fr.plane_tail_number, 
       fr.year, 
       Avg(da.avg) AS daily_avg 
FROM   flight_reports fr, 
       (SELECT fr.plane_tail_number, 
               fr.year, 
               fr.month, 
               fr.day, 
               Count(*) AS avg 
        FROM   flight_reports fr 
        WHERE  fr.is_cancelled = '0' 
        GROUP  BY fr.plane_tail_number, 
                  fr.year, 
                  fr.month, 
                  fr.day 
        ORDER  BY fr.plane_tail_number, 
                  fr."year") AS da 
WHERE  fr.plane_tail_number = da.plane_tail_number 
       AND fr.year = da.year 
GROUP  BY fr.plane_tail_number, 
          fr.year 
HAVING Avg(da.avg) > 5 
ORDER  BY fr.plane_tail_number, 
          fr.year 