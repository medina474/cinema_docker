create function films_with_texte(mot text)
returns table (film_id films.film_id%TYPE
  , titre films.titre%TYPE)
language sql
as $function$
	select f.film_id, f.titre from films f
    inner join resumes r on f.film_id = r.film_id
  where ts @@ to_tsquery('french', mot);
$function$;

create function reco()
  returns table (id films.film_id%TYPE
  ,titre films.titre%type
  ,votants votes.votants%type
  ,moyenne votes.moyenne%type
  ,score float)
  language 'plpgsql'
as $body$
declare
  C float;
  m int;
begin
  select avg(f.vote_moyenne) into C
    from votes f;
  select percentile_disc(0.9) into m
    within group (order by votes.votants)
    from films;
  return query select f.film_id, f.titre, f.votants
  	,f.vote_moyenne
  	,(f.votants::numeric /(f.votants::numeric + m) * f.vote_moyenne) + (m /(f.votants::numeric + m) * C) as score
    from votes f
    where f.votants >= m
    order by score desc
    limit 10;
end
$body$;

create function films_par_acteur (id varchar)
RETURNS TABLE(film_id uuid, titre text, titre_original text,
annee int, sortie date, duree int, votants int, vote_moyenne numeric(4,2), franchise text, alias text[], genres text[], motscles text[], resume text) AS
$$
BEGIN
  return query select f.film_id, f.titre, f.titre_original,
      f.annee, f.sortie, f.duree, f.vote_votants, f.vote_moyenne,
      f2.franchise
      , array_agg(distinct e.alias) as alias
      , array_agg(distinct g.genre) as genres
      , array_agg(distinct mc.motcle) as motscles
      , r.resume
    from films f
    inner join equipes e on e.film_id = f.film_id and e.alias is not null
    left join films_genres fg on fg.film_id = f.film_id
    left join genres g on g.genre_id = fg.genre_id
    left join franchises f2 on f2.franchise_id = f.franchise_id
    left join lateral (SELECT r2.resume FROM resumes r2 WHERE r2.film_id  = f.film_id
      order by array_position(array['deu','fra','eng'], r2.langue_code)
      fetch first 1 row only ) r on true
    left join films_motscles fmc on fmc.film_id = f.film_id
    left join motscles mc on mc.motcle_id = fmc.motcle_id
    where e.personne_id = id::uuid
    group by f.film_id, f.titre, f.titre_original, f2.franchise, f.vote_votants, e.ordre, r.resume
    order by e.ordre, vote_votants desc;
END;
$$
language plpgsql volatile;

create function etablissements_in_view(min_lat float, min_long float, max_lat float, max_long float)
returns table (etablissement_id etablissements.etablissement_id%TYPE
  , nom etablissements.nom%TYPE
	, ville etablissements.ville%TYPE
	, voie etablissements.voie%TYPE
	, codepostal etablissements.codepostal%TYPE
	, lat float, long float)
language sql
as $function$
	select etablissement_id
		, nom
		, ville
		, voie
		, codepostal
		, st_y(coordonnees::geometry) as lat, st_x(coordonnees::geometry) as long
	from etablissements
	where coordonnees OPERATOR(&&) ST_SetSRID(ST_MakeBox2D(ST_Point(min_long, min_lat), ST_Point(max_long, max_lat)), 4326)
$function$;
