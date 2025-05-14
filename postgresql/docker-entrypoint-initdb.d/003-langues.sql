create table langues (
  code3 char(3) not null,
  langue text default null,
  francais text default null
);

comment on table langues is 'ISO 639-3';

alter table langues
  add check (code3 ~ '^[a-z]{3}$');

create unique index langues_pk
  on langues
  using btree (code3);

alter table langues
  add primary key using index langues_pk;

\copy langues from '/tmp/003-langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

--alter table langues owner to cinema;
