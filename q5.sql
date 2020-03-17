SELECT ( Cast(f1.day AS VARCHAR(10)) 
         || '/' 
         || Cast(f1.month AS VARCHAR(10)) 
         || '/' 
         || Cast(f1.year AS VARCHAR(10)) )     AS flight_date, 
       f1.plane_tail_number, 
       f1.arrival_time                         AS flight1_arrival_time, 
       f2.departure_time                       AS flight2_departure_time, 
       f1.origin_city_name, 
       f1.dest_city_name, 
       f2.dest_city_name, 
       f1.flight_time + f1.taxi_out_time 
       + f2.flight_time + f2.taxi_in_time      AS total_time, 
       f1.flight_distance + f2.flight_distance AS total_distance 
FROM   (SELECT * 
        FROM   flight_reports fr 
        WHERE  fr.is_cancelled = '0' 
               AND fr.origin_city_name = 'Seattle, WA') f1, 
       (SELECT * 
        FROM   flight_reports fr 
        WHERE  fr.is_cancelled = '0' 
               AND fr.dest_city_name = 'Boston, MA') f2 
WHERE  f1.dest_city_name = f2.origin_city_name 
       AND f1.year = f2.year 
       AND f1.month = f2.month 
       AND f1.day = f2.day 
       AND f1.arrival_time < f2.departure_time 
       AND f1.plane_tail_number = f2.plane_tail_number 
ORDER  BY total_time, 
          total_distance, 
          f1.plane_tail_number, 
          f1.dest_city_name 