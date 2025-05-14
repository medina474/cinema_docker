do $$
begin
  for counter in 1..1000 loop
	INSERT INTO seances (film_id, salle_id, seance)
  	VALUES ((SELECT film_id FROM films WHERE random() > 0.9 ORDER BY random() LIMIT 1)
    , (FLOOR(random()*77)+1)
    , (date(now() + trunc(random()  * 14) * '1 day'::interval)+ '21hour'::interval));
  end loop;
end; $$

-- https://stackoverflow.com/questions/12618232/copy-a-few-of-the-columns-of-a-csv-file-into-a-table
