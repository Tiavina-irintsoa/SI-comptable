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

