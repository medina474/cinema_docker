create temporary table etablissement_tmp
(
  regionCNC smallint,
  nauto integer,
  nom text,
  région_administrative text,
  adresse text,
  code_insee text,
  commune text,
  population text,
  dep text,
  nuu text,
  unité_urbaine text,
  population_unité_urbaine text,
  situation_géographique text,
  écrans smallint,
  fauteuils smallint,
  semaines_activité text,
  séances text,
  entrées_2023 text,
  entrées_2022 text,
  évolution_entrées text,
  tranche_entrées text,
  propriétaire text,
  ae text,
  catégorie_art_et_essai text,
  label_art_et_essai text,
  genre text,
  multiplexe text,
  zone_commune text,
  nombre_films_programmés text,
  nombre_films_inédits text,
  nombre_films_en_semaine_1 text,
  pdm_films_français text,
  pdm_films_américains text,
  pdm_films_européens text,
  pdm_autres_films text,
  films_art_et_essai text,
  part_séances_films_art_et_essai text,
  pdm_films_art_et_essai text,
  latitude float,
  longitude float,
  extra text
);

\copy etablissement_tmp from '/tmp/cnc-données-cartographie-2023.csv' delimiter ';' csv header quote '"' encoding 'utf8';

insert into etablissements (etablissement_id, nom, voie, ville, ecrans, fauteuils, coordonnees)
  select nauto, nom, adresse, commune, écrans, fauteuils, st_makepoint(longitude, latitude)
  from etablissement_tmp;

drop table etablissement_tmp;

--

\copy genres from '/tmp/041-genres.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
\copy series from '/tmp/041-series.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

\copy films (film_id,titre,titre_original,annee,sortie,duree,serie_id, pays) from '/tmp/030-films.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

\copy films_genres (film_id, genre_id) from '/tmp/041-films_genres.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

\copy personnes (personne_id, nom, prenom, naissance, deces, nationalite, artiste, popularite) from '/tmp/010-personnes.csv' delimiter ',' csv header quote '"' encoding 'utf8';
\copy societes from '/tmp/011-societes.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
\copy equipes from '/tmp/031-equipes.csv' delimiter ',' csv header quote '"' encoding 'utf8';
\copy productions (film_id, societe_id) from '/tmp/041-productions.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

\copy links_films from '/tmp/042-links_films.csv' (format csv, header, encoding 'utf8');
\copy links_personnes from '/tmp/042-links_personnes.csv' (format csv, header, encoding 'utf8');

\copy salles (salle_id, etablissement_id, salle, sieges) from '/tmp/043-salles.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
\copy resumes (film_id, langue, resume) from '/tmp/044-resumes.csv' delimiter ',' csv header quote '"' escape '"' encoding 'utf8';
\copy certifications (pays_code,ordre,certification,description) from '/tmp/046-certifications.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

-- Mots clés
\copy motscles (motcle_id,motcle) from '/tmp/030-motscles.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
\copy films_motscles (film_id,motcle_id) from '/tmp/030-films_motscles.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

-- Slogans
create temporary table slogan_tmp
(
  film_id int,
  slogan text
);

\copy slogan_tmp from '/tmp/030-films_slogan.csv' delimiter ',' csv header quote '"' encoding 'utf8';

UPDATE films AS f
SET slogan = t.slogan
FROM slogan_tmp AS t
WHERE f.film_id = t.film_id;

\copy votes (film_id, votants, moyenne) from '/tmp/060-votes.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

\copy quizzes from '/tmp/070-quizzes.csv' delimiter ',' csv header quote '''' escape '\' encoding 'utf8';
