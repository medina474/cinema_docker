create table votes (
  film_id int not null,
  votants int default 0,
  moyenne decimal not null default 0.0
);

alter table votes
  add foreign key (film_id) references films;


create table user_votes (
  user_id int not null,
  film_id int not null,
  note decimal not null,
  timestamp timestamp with time zone not null
);

create unique index votes_pkey
  on user_votes
  using btree (film_id, user_id);

alter table user_votes
  add primary key
  using index votes_pkey;


create index vote_film_fki
  on user_votes(film_id);

alter table user_votes
  add constraint vote_film_fk
  foreign key (film_id)
  references films (film_id) match simple
  on update no action
  on delete cascade;

alter table user_votes
  add constraint note_check check (note >= 0 and note < 6) not valid;

CREATE FUNCTION vote_calcul()
  RETURNS trigger
  LANGUAGE 'plpgsql'
AS $BODY$
declare
   moyenne decimal(4,2);
   votants integer;
BEGIN
  SELECT count(*), avg(note) INTO votants, moyenne FROM votes WHERE film_id = NEW.film_id;
  UPDATE votes SET vote_votants=COALESCE(votants,0), vote_moyenne=COALESCE(moyenne,0) WHERE film_id = NEW.film_id;
  RETURN NEW;
END
$BODY$;

create trigger trigger_vote_insert
  after insert
  on user_votes
  for each row
  execute function vote_calcul();

create trigger trigger_vote_update
  after update
  on user_votes
  for each row
  execute function vote_calcul();
