SELECT mf.airline_name, 
       mf.monday_flights, 
       sf.sunday_flights 
FROM   (SELECT ac.airline_name, 
               Count(*) AS monday_flights 
        FROM   flight_reports fr, 
               airline_codes ac 
        WHERE  fr.airline_code = ac.airline_code 
               AND fr.is_cancelled = '0' 
               AND fr.weekday_id = '1' 
        GROUP  BY ac.airline_code, 
                  ac.airline_name) AS mf, 
       (SELECT ac.airline_name, 
               Count(*) AS sunday_flights 
        FROM   flight_reports fr, 
               airline_codes ac 
        WHERE  fr.airline_code = ac.airline_code 
               AND fr.is_cancelled = '0' 
               AND fr.weekday_id = '7' 
        GROUP  BY ac.airline_code, 
                  ac.airline_name) AS sf 
WHERE  mf.airline_name = sf.airline_name 
ORDER  BY mf.airline_name 