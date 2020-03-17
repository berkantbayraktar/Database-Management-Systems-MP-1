SELECT DISTINCT fr.plane_tail_number, 
                fr.airline_code  AS first_owner, 
                fr2.airline_code AS second_owner 
FROM   flight_reports fr, 
       flight_reports fr2 
WHERE  fr.plane_tail_number = fr2.plane_tail_number 
       AND fr.airline_code <> fr2.airline_code 
       AND (fr.year < fr2.year 
       		or (fr.year = fr2.year and fr.month < fr2.month)
       		or (fr.year < fr2.year and fr.month = fr2.month and fr.day < fr2.day)
       		)
ORDER  BY fr.plane_tail_number, fr.airline_code, fr2.airline_code