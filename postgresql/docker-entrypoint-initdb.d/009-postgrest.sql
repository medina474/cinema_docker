-- Role public
create role role_web nologin;

-- PostgREST
create role postgrest noinherit login password '9012';
grant role_web to postgrest;

grant usage on schema public to role_web;

alter default privileges in schema public
  grant select on tables to role_web;
