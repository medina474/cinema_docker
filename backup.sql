-- Cinema

\copy certifications to 'postgresql/data/046-certifications.csv' (format csv, header);
\copy (select film_id, personne_id, role, alias, ordre from equipes order by film_id, personne_id, role, alias) to 'postgresql/data/031-equipes.csv' (format csv, header, encoding 'utf8');
\copy (select film_id, titre, titre_original, annee, sortie, duree, serie_id, pays from films order by film_id) to 'postgresql/data/030-films.csv' (format csv, header, encoding 'utf8');
\copy (select film_id, slogan from films where slogan is not null order by film_id) to 'postgresql/data/030-films_slogan.csv' (format csv, header, encoding 'utf8');
\copy (select film_id, genre_id from films_genres order by film_id) to 'postgresql/data/041-films_genres.csv' (format csv, header, encoding 'utf8');
\copy (select id, site_id, identifiant from links_personnes order by id, site_id) to 'postgresql/data/042-links_personnes.csv' (format csv, header, encoding 'utf8');
\copy (select id, site_id, identifiant from links_films order by id, site_id) to 'postgresql/data/042-links_films.csv' (format csv, header, encoding 'utf8');
\copy (select personne_id, nom, prenom, naissance, deces, nationalite, artiste, popularite from personnes order by personne_id) to 'postgresql/data/010-personnes.csv' (format csv, header, encoding 'utf8');
\copy (select film_id, societe_id from productions order by film_id, societe_id) to 'postgresql/data/041-productions.csv' (format csv, header, encoding 'utf8');
\copy (select film_id, langue, resume from resumes where resume <> '' order by film_id, langue) to 'postgresql/data/044-resumes.csv' (format csv, header, delimiter ',', quote '"', escape '"', encoding 'utf8');
\copy (select salle_id, etablissement_id, salle, sieges from salles) to 'postgresql/data/043-salles.csv' delimiter ',' csv header  encoding 'utf8';

--\copy franchises to 'data/franchises.csv' (format csv, header, encoding 'utf8');
--\copy (select film_id, slogan from films where slogan <> '' order by film_id) to 'data/films_slogan.csv' (format csv, header, delimiter ',', encoding 'utf8');
--\copy (select societe_id, societe, uei from societes order by societe_id) to 'data/societes.csv' (format csv, header, encoding 'utf8');
--\copy (select * from votes order by film_id)  to 'data/votes.csv' (format csv, header, encoding 'utf8');

-- Mots clés
\copy (select * from motscles order by motcle_id) to 'postgresql/data/030-motscles.csv' (format csv, header, encoding 'utf8');
\copy (select film_id, motcle_id from films_motscles order by film_id, motcle_id) to 'postgresql/data/030-films_motscles.csv' (format csv, header, encoding 'utf8');
