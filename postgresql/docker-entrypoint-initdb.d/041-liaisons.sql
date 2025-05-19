create table films_genres (
  film_id int not null,
  genre_id integer not null
);

create unique index film_genres_pkey
  on films_genres
  using btree (film_id, genre_id);

alter table films_genres
  add primary key
  using index film_genres_pkey;

-- films_genres -> films
create index on films_genres(film_id);

alter table films_genres
add foreign key (film_id)
  references films(film_id)
  on delete cascade;

-- films_genres -> genres
create index on films_genres(genre_id);

alter table films_genres
add foreign key (genre_id)
  references genres(genre_id)
  on delete cascade;


-- Productions

create table productions (
  film_id int not null,
  societe_id int not null
);

create index on productions
  using btree (film_id);

create index on productions
  using btree (societe_id);

alter table productions
  add primary key (film_id, societe_id);

alter table productions
add constraint productions_film_id_fkey
  foreign key (film_id) references films(film_id)
  on delete cascade;

alter table productions
add constraint productions_societe_id_fkey
  foreign key (societe_id) references societes(societe_id)
  on delete cascade;


-- sites

create table sites (
  site_id smallint not null,
  site text not null,
  url text not null
);

alter table sites
  add primary key (site_id);

insert into sites values
  (1,'TMDB (The Movie Database)','https://www.themoviedb.org/movie/$id'),
  (2,'IMDb (Internet Movie Database)','https://www.imdb.com/title/$id'),
  (3,'Wikipedia','https://fr.wikipedia.org/wiki/$id'),
  (4,'YouTube','https://youtu.be/$id'),
  (5,'Sens Critique','https://www.senscritique.com/film/_/$id'),
  (6,'AlloCiné','https://www.allocine.fr/film/fichefilm_gen_cfilm=$id.html');

create table links (
  id int not null,
  site_id smallint not null,
  identifiant text not null
);

alter table links
  add constraint links_no_insert_in_parent
  check (false) no inherit;

alter table links
  add primary key (id, site_id);

create table links_films (
) inherits (links);

create table links_personnes (
) inherits (links);

alter table links_films
  add primary key (id, site_id);

alter table links_personnes
  add primary key (id, site_id);

create index links_films_id
  on links_films(id);

create index links_films_site
  on links_films(site_id);

alter table links_films
  add foreign key (id)
  references films(film_id)
  on delete cascade;

alter table links_films
add foreign key (site_id)
  references sites
  on delete cascade;

-- Links Personnes

create index links_personnes_id
  on links_personnes(id);

create index links_personnes_site
  on links_personnes(site_id);

alter table links_personnes
  add foreign key (id)
  references personnes(personne_id)
  on delete cascade;

alter table links_personnes
add foreign key (site_id)
  references sites
  on delete cascade;
