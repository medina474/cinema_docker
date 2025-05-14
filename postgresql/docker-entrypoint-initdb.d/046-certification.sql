create table certifications (
  pays_code text not null,
  ordre smallint,
  certification text not null,
  description text
);

create unique index certifications_pk
  on certifications
  using btree (pays_code, certification);

alter table certifications
  add primary key using index certifications_pk;

create index certifications_pays_idx
  on certifications
  using btree (pays_code, ordre);


alter table certifications
  add foreign key (pays_code)
    references pays (code2);


create table films_certifications (
  film_id integer,
  pays_code text,
  certification text,
  description text
);

alter table films_certifications
  add foreign key (film_id)
    references films;

alter table films_certifications
  add foreign key (pays_code, certification)
    references certifications;
