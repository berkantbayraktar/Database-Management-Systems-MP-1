SELECT DISTINCT ac.airline_name 
FROM   flight_reports fr3, 
       airline_codes ac, 
       (SELECT fr.airline_code, 
               fr.plane_tail_number 
        FROM   flight_reports fr, 
               world_area_codes wac 
        WHERE  fr.dest_wac_id = wac.wac_id 
               AND wac.wac_name = 'Texas' 
        EXCEPT 
        SELECT fr2.airline_code, 
               fr2.plane_tail_number 
        FROM   flight_reports fr2, 
               world_area_codes wac2 
        WHERE  fr2.dest_wac_id = wac2.wac_id 
               AND wac2.wac_name <> 'Texas') AS fr4 
WHERE  fr3.plane_tail_number = fr4.plane_tail_number 
       AND fr3.airline_code = ac.airline_code 
ORDER  BY ac.airline_name 