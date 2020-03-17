SELECT ac.airline_name, 
       fr.airline_code, 
       Avg(fr.departure_delay) AS avg_delay 
FROM   flight_reports fr, 
       airline_codes ac 
WHERE  ac.airline_code = fr.airline_code 
       AND fr."year" = '2018' 
       AND fr.is_cancelled = '0' 
GROUP  BY ac.airline_name, 
          fr.airline_code 
ORDER  BY Avg(fr.departure_delay), 
          ac.airline_name 