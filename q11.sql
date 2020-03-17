SELECT t5.airline_name, 
       t5.year, 
       t5.total_num_flights, 
       t5.cancelled_flights 
FROM   (SELECT t3.airline_name 
        FROM   (SELECT t1.airline_name, 
                       t1.year, 
                       t1.total_num_flights, 
                       t2.cancelled_flights 
                FROM   (SELECT ac.airline_name, 
                               fr."year", 
                               Count(*) AS total_num_flights 
                        FROM   flight_reports fr, 
                               airline_codes ac 
                        WHERE  fr.airline_code = ac.airline_code 
                        GROUP  BY ac.airline_name, 
                                  fr."year" 
                        HAVING Count(*) / ( Max(fr.day) - Min(fr.day) + 1 ) > 
                               2000) AS 
                       t1, 
                       (SELECT ac.airline_name, 
                               fr."year", 
                               Count(*) AS cancelled_flights 
                        FROM   flight_reports fr, 
                               airline_codes ac 
                        WHERE  fr.airline_code = ac.airline_code 
                               AND fr.is_cancelled = '1' 
                        GROUP  BY ac.airline_name, 
                                  fr."year") AS t2 
                WHERE  t1.airline_name = t2.airline_name 
                       AND t1.year = t2.year) AS t3 
        GROUP  BY t3.airline_name 
        HAVING Count(*) > 2) AS t4, 
       (SELECT t1.airline_name, 
               t1.year, 
               t1.total_num_flights, 
               t2.cancelled_flights 
        FROM   (SELECT ac.airline_name, 
                       fr."year", 
                       Count(*) AS total_num_flights 
                FROM   flight_reports fr, 
                       airline_codes ac 
                WHERE  fr.airline_code = ac.airline_code 
                GROUP  BY ac.airline_name, 
                          fr."year" 
                HAVING Count(*) / ( Max(fr.day) - Min(fr.day) + 1 ) > 2000) AS 
               t1, 
               (SELECT ac.airline_name, 
                       fr."year", 
                       Count(*) AS cancelled_flights 
                FROM   flight_reports fr, 
                       airline_codes ac 
                WHERE  fr.airline_code = ac.airline_code 
                       AND fr.is_cancelled = '1' 
                GROUP  BY ac.airline_name, 
                          fr."year") AS t2 
        WHERE  t1.airline_name = t2.airline_name 
               AND t1.year = t2.year) AS t5 
WHERE  t5.airline_name = t4.airline_name 