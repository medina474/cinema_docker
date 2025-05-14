create schema extensions authorization pg_database_owner;

create extension postgis schema extensions;
create extension fuzzystrmatch schema extensions;

alter database cinema set search_path = public,extensions;
