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

-- --------------------------------------------
create table mois(
  idmois SERIAL PRIMARY KEY,
  mois varchar(20)
);

