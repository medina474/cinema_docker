create table etablissements (
  etablissement_id integer not null,
  nom text,
  voie text,
  codepostal text,
  ville text,
  ecrans smallint,
  fauteuils smallint,
  coordonnees geometry(Point, 4326) default null::geometry,
  constraint cinema_pkey primary key (etablissement_id)
);

create index cinema_coordonnees_idx
  on etablissements
  using GIST (coordonnees);

alter table etablissements
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;
