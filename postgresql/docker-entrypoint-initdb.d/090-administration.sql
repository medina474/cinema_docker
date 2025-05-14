CREATE VIEW personnes_sans_role
 AS
 SELECT p.personne_id,
   p.prenom,
   p.nom,
   count(e.personne_id) AS nb
   FROM personnes p
     LEFT JOIN equipes e ON e.personne_id = p.personne_id
  GROUP BY p.personne_id, p.prenom, p.nom
 HAVING count(e.personne_id) = 0;


CREATE VIEW films_sans_role
 AS
 SELECT f.titre,
   count(e.film_id) AS nb
   FROM films f
     LEFT JOIN equipes e ON e.film_id = f.film_id
  GROUP BY f.titre
 HAVING count(e.film_id) = 0;
