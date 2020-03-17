SELECT ac2.airline_name 
FROM   airline_codes ac2 
WHERE  ac2.airline_name IN (SELECT ac.airline_name 
                            FROM   flight_reports fr, 
                                   airline_codes ac 
                            WHERE  fr.airline_code = ac.airline_code 
                                   AND fr.is_cancelled = '0' 
                                   AND fr.dest_city_name = 'Boston, MA' 
                                   AND ( fr."year" = '2016' 
                                          OR fr."year" = '2017' ) 
                            INTERSECT 
                            SELECT ac.airline_name 
                            FROM   flight_reports fr, 
                                   airline_codes ac 
                            WHERE  fr.airline_code = ac.airline_code 
                                   AND fr.is_cancelled = '0' 
                                   AND fr.dest_city_name = 'New York, NY' 
                                   AND ( fr."year" = '2016' 
                                          OR fr."year" = '2017' ) 
                            INTERSECT 
                            SELECT ac.airline_name 
                            FROM   flight_reports fr, 
                                   airline_codes ac 
                            WHERE  fr.airline_code = ac.airline_code 
                                   AND fr.is_cancelled = '0' 
                                   AND fr.dest_city_name = 'Portland, ME' 
                                   AND ( fr."year" = '2016' 
                                          OR fr."year" = '2017' ) 
                            INTERSECT 
                            SELECT ac.airline_name 
                            FROM   flight_reports fr, 
                                   airline_codes ac 
                            WHERE  fr.airline_code = ac.airline_code 
                                   AND fr.is_cancelled = '0' 
                                   AND fr.dest_city_name = 'Washington, DC' 
                                   AND ( fr."year" = '2016' 
                                          OR fr."year" = '2017' ) 
                            INTERSECT 
                            SELECT ac.airline_name 
                            FROM   flight_reports fr, 
                                   airline_codes ac 
                            WHERE  fr.airline_code = ac.airline_code 
                                   AND fr.is_cancelled = '0' 
                                   AND fr.dest_city_name = 'Philadelphia, PA' 
                                   AND ( fr."year" = '2016' 
                                          OR fr."year" = '2017' )) 
ORDER  BY ac2.airline_name 