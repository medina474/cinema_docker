create table resumes (
  film_id int not null,
  langue text not null,
  resume text not null
);

alter table resumes
  add column ts tsvector
  generated always as (to_tsvector('french', resume)) stored;

CREATE INDEX resume_texte_idx
  ON resumes USING GIN(ts);

-- Clé primaire composée

create unique index resumes_pk
  on resumes
  using btree (film_id, langue);

alter table resumes
  add primary key using index resumes_pk;

create index resume_film_fki
  on resumes(film_id);

-- Clé étrangère

alter table resumes
  add FOREIGN KEY (film_id)
  REFERENCES films;

alter table resumes
  add FOREIGN KEY (langue)
  REFERENCES langues (code3);


-- SELECT * from resume WHERE ts @@ to_tsquery('french', 'romancier');
