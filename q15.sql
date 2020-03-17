SELECT ac.airport_desc 
FROM   airport_codes ac, 
       (SELECT o_flights.origin_airport_code, 
               o_flights.origin_flights 
               + d_flights.desc_flights AS total_flights 
        FROM   (SELECT fr.origin_airport_code, 
                       Count(*) AS origin_flights 
                FROM   flight_reports fr 
                WHERE  fr.is_cancelled = '0' 
                GROUP  BY fr.origin_airport_code) AS o_flights, 
               (SELECT fr.dest_airport_code, 
                       Count(*) AS desc_flights 
                FROM   flight_reports fr 
                WHERE  fr.is_cancelled = '0' 
                GROUP  BY fr.dest_airport_code) AS d_flights 
        WHERE  o_flights.origin_airport_code = d_flights.dest_airport_code 
        ORDER  BY o_flights.origin_flights 
                  + d_flights.desc_flights DESC 
        LIMIT  5) AS t_flights 
WHERE  ac.airport_code = t_flights.origin_airport_code 
ORDER  BY ac.airport_desc 