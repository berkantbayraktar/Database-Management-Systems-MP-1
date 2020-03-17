SELECT ac.airline_name, 
       ( Count(*) * 100 / (SELECT Count(*) 
                           FROM   flight_reports fr2 
                           WHERE  fr2.dest_city_name = 'Boston, MA' 
                                  AND fr2.airline_code = fr.airline_code 
                           GROUP  BY fr2.airline_code) ) AS percentage 
FROM   flight_reports fr, 
       airline_codes ac 
WHERE  fr.airline_code = ac.airline_code 
       AND fr.dest_city_name = 'Boston, MA' 
       AND fr.is_cancelled = '1' 
GROUP  BY fr.airline_code, 
          ac.airline_name 
HAVING Count(*) * 10 > (SELECT Count(*) 
                        FROM   flight_reports fr2 
                        WHERE  fr2.dest_city_name = 'Boston, MA' 
                               AND fr2.airline_code = fr.airline_code 
                        GROUP  BY fr2.airline_code) 
ORDER  BY percentage DESC 