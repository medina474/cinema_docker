create table pays (
  code text not null,
  pays text not null,
  drapeau_unicode character(2)
);

comment on column pays.code
  is 'code ISO 3166-1 alpha 2';

create index pays_nom
  on pays using btree (pays asc nulls last);

alter table pays
  add check (code ~ '^[a-z]{2}$');

create unique index pays_pk
  on pays
  using btree (code);

alter table pays
  add primary key using index pays_pk;

\copy pays (code, pays, drapeau_unicode) from '/tmp/002-pays.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

--alter table pays owner to cinema;
