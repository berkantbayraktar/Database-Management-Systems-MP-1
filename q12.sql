SELECT bf.year, 
       bf.airline_code, 
       bf.boston_flight_count, 
       bf.boston_flight_count * 100.0 / af.all_flight_count AS 
       boston_flight_percentage 
FROM   (SELECT fr.year, 
               fr.airline_code, 
               Count(*) AS boston_flight_count 
        FROM   flight_reports fr 
        WHERE  fr.is_cancelled = '0' 
               AND fr.dest_city_name = 'Boston, MA' 
        GROUP  BY fr.year, 
                  fr.airline_code 
        ORDER  BY fr.year, 
                  fr.airline_code) AS bf, 
       (SELECT fr.year, 
               fr.airline_code, 
               Count(*) AS all_flight_count 
        FROM   flight_reports fr 
        WHERE  fr.is_cancelled = '0' 
        GROUP  BY fr.year, 
                  fr.airline_code 
        ORDER  BY fr.year, 
                  fr.airline_code) AS af 
WHERE  bf.year = af.year 
       AND bf.airline_code = af.airline_code 
       AND bf.boston_flight_count * 100 > af.all_flight_count 
ORDER  BY bf.year, 
          bf.airline_code 