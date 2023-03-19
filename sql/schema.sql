CREATE TABLE description (
  iddescription SERIAL PRIMARY KEY,
  description TEXT
);

CREATE TABLE informations (
  idinfo SERIAL PRIMARY KEY,
  iddescription INTEGER REFERENCES description (iddescription),
  valeur TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE dirigeant (
  id SERIAL PRIMARY KEY,
  nom TEXT,
  date DATE,
  email TEXT
);

CREATE TABLE exercice (
  idexercice SERIAL PRIMARY KEY,
  debut DATE
);

CREATE TABLE devise (
  iddevise SERIAL PRIMARY KEY,
  nom TEXT not null
);

CREATE TABLE devisequivalence (
  idquivalence SERIAL PRIMARY KEY,
  iddevise INTEGER REFERENCES devise (iddevise),
  taux NUMERIC(10, 2) not null
);

CREATE TABLE compte (
  idcompte SERIAL PRIMARY KEY,
  numero TEXT not null unique,
  libelle TEXT not null
);

CREATE TABLE tiers (
  idtiers SERIAL PRIMARY KEY,
  idcompte INTEGER REFERENCES compte (idcompte),
  nom TEXT not null
);

CREATE TABLE journal (
  idjournal SERIAL PRIMARY KEY,
  code varchar not null,
  nom varchar not null,
  date DATE default now()
);

create table mois(
  idmois SERIAL PRIMARY KEY,
  mois varchar(20)
);


create table admin(
  idadmin SERIAL primary key,
  nom varchar unique,
  mdp varchar
);  

create table formulaireSociete(
    idform serial primary key,
    nom varchar,
    valeur varchar,
    date timestamp default now()
);

create table verification(
    idverif serial primary key,
    name varchar,
    min numeric,
    max numeric
);

create table nbEmploye(
    idnbempl serial primary key,
    valeur integer,
    date date default now()  
);


create or replace view date_exercice as (
    select exercice.* , getDateFin(exercice.debut) as fin from exercice
);

create or replace view date_exrcice_extract as (
    select idexercice ,
    to_char(debut, 'DD ') as jour_debut,
    to_char(debut, 'MM') as mois_debut,
    to_char(debut, ' YYYY') as annee_debut,

    to_char(fin, 'DD ') as jour_fin,
    to_char(fin, 'MM') as mois_fin,
    to_char(fin, ' YYYY') as annee_fin
    from date_exercice
);

create or replace view dirigeant_date_extract as (
    select id ,
    nom ,
    email,
    to_char(date, 'DD ') as jour,
    to_char(date, 'MM') as mois,
    to_char(date, ' YYYY') as annee
    from dirigeant
);

create or replace view tiers_compte as(
    select tiers.*,compte.numero
    from tiers
    join compte
    on compte.idcompte=tiers.idcompte
);

create or replace view info_description as (
    select informations.* , description.description 
    from informations
    join description
    on informations.iddescription = description.iddescription
);

