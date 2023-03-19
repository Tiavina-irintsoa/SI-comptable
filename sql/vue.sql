create or replace view info_description as (
    select informations.* , description.description 
    from informations
    join description
    on informations.iddescription = description.iddescription
);

-- ----------------------------------------------------

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
    select  * from getLast_infos()
);

-- vue compte tiers par ordre alphabetique
create or replace view tiers_alphabet as (
    select * from tiers order by nom
);

-- vue compte par ordre numerique
create or replace view compte_trie as (
    select * from compte order by numero
);

-- vue tiers trie sy numero de compte
create or replace view tiers_compte as (
    select tiers_alphabet.* ,  compte.numero from tiers_alphabet
    join compte
    on tiers_alphabet.idcompte = compte.idcompte
);