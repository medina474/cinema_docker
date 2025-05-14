create table pays (
  code2 text not null,
  code3 text not null,
  pays text not null,
  forme_longue text,
  drapeau_unicode character(2)
);

comment on column pays.code2
  is 'code ISO 3166-1 alpha 2';

comment on column pays.code3
  is 'code ISO 3166-1 alpha 3';

create index pays_nom
  on pays using btree (pays asc nulls last);

alter table pays
  add check (code2 ~ '^[A-Z]{2}$');

alter table pays
  add check (code3 ~ '^[A-Z]{3}$');

create unique index pays_pk
  on pays
  using btree (code2);

alter table pays
  add primary key using index pays_pk;

\copy pays (code2, code3, pays, drapeau_unicode, forme_longue) from '/tmp/002-pays.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

--alter table pays owner to cinema;
