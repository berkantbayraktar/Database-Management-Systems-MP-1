SELECT ac.airport_code, 
       ac.airport_desc, 
       Count(*) AS cancel_count 
FROM   flight_reports fr, 
       airport_codes ac, 
       cancellation_reasons cr 
WHERE  fr.origin_airport_code = ac.airport_code 
       AND fr.cancellation_reason = cr.reason_code 
       AND fr.is_cancelled = '1' 
       AND cr.reason_desc = 'Security' 
GROUP  BY ac.airport_code, 
          ac.airport_desc 
ORDER  BY Count(*) DESC, 
          ac.airport_code 