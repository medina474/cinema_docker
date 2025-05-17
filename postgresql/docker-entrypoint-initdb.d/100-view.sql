create materialized view acteurs as
  select p.personne_id,
  case
    when (p.artiste is not null) then (p.artiste)::text
    else (((p.prenom)::text || ' '::text) || (p.nom)::text)
  end as nom,
  case
    when (p.artiste is not null) then metaphone(p.artiste::text,15)
    else metaphone(((p.prenom)::text || ' '::text) || (p.nom)::text,15)
  end as metaphone,
  p.naissance,
  case
    when (p.deces is null) then date_part('year'::text, age((p.naissance)::timestamp with time zone))
    else null::double precision
  end as age,
  p.deces,
  p.nationalite,
  y.drapeau_unicode,
  count(distinct c.film_id) as nb_film,
  p.popularite
  from (equipes c
    join personnes p on (c.personne_id = p.personne_id)
    left join pays y on p.nationalite = y.code)
  where c.role in ('acteur', 'voix')
  group by p.personne_id, y.drapeau_unicode
  order by popularite desc
with no data;


create view check_films_sans_equipe as
 select f.film_id, f.titre,
    count(e.film_id) as nb
  from films f
    left join equipes e on e.film_id = f.film_id
  group by f.film_id, f.titre
  having count(e.film_id) = 0;

create view check_personnes_sans_role as
 select p.personne_id,
    p.prenom,
    p.nom,
    count(e.personne_id) as nb
  from personnes p
    left join equipes e on e.personne_id = p.personne_id
  group by p.personne_id, p.prenom, p.nom
  having count(e.personne_id) = 0;


create or replace view view_debug as  select fg.film_id,
    fg.genre_id
   from (films_genres fg
     left join films f on ((fg.film_id = f.film_id)))
  where (f.film_id = null);


create or replace view view_films_tmdb as  select f.titre,
    f.film_id
   from (films f
     left join links l on (((f.film_id = l.id) and (l.site_id = 1))))
  where (l.id is null);


create or replace view view_personnes_tmdb as  select p.nom,
    p.prenom,
    p.personne_id
   from (personnes p
     left join links l on (((p.personne_id = l.id) and (l.site_id = 1))))
  where (l.id is null);


create or replace view view_nb_films as  select p.nom,
    l.identifiant,
    count(e.film_id) as count
   from ((personnes p
     join equipes e on ((p.personne_id = e.personne_id)))
     left join links l on (((p.personne_id = l.id) and (l.site_id = 1))))
  group by p.nom, l.identifiant;


create or replace view view_films_tmdb as  select f.titre,
    f.film_id
   from (films f
     left join links l on ((f.film_id = l.id) and (l.site_id = 1)))
  where (l.id is null);


create or replace view view_personnes_tmdb as
  select p.nom,
    p.prenom,
    p.personne_id
   from (personnes p
     left join links l on ((p.personne_id = l.id) and (l.site_id = 1)))
  where (l.id is null);

create or replace view view_simili as
SELECT fk1.film_id AS film1,
       fk2.film_id AS film2,
       COUNT(*) AS common_keywords
FROM films_motscles fk1
JOIN films_motscles fk2
  ON fk1.motcle_id = fk2.motcle_id
 AND fk1.film_id < fk2.film_id  -- Assure de ne pas compter les mêmes paires deux fois
GROUP BY fk1.film_id, fk2.film_id
HAVING COUNT(*) > 0
ORDER BY common_keywords DESC;
