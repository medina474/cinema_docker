create table equipes (
  film_id int not null,
  personne_id int not null,
  role role,
  alias text,
  ordre int2 null default 99
);

comment on table equipes is
  e'@foreignkey (personne) references acteur(id)|@fieldname rolebyacteur';


/*
constraint equipe_film_fk foreign key (film) references films(id)
    on update no action on delete no action not valid,
  constraint equipe_personne_fk foreign key (personne) references personnes(id)
    on update no action on delete no action not valid
*/

-- equipes -> films
create index on equipes(film_id);

alter table equipes
add foreign key (film_id)
  references films
  on delete cascade;

-- equipes -> personnes
create index on equipes(personne_id);

alter table equipes
add foreign key (personne_id)
  references personnes
  on delete cascade;

comment on table equipes is
  e'@foreignkey (personne) references acteur(id)|@fieldname rolebyacteur';
