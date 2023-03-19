INSERT INTO description (description) VALUES 
('nom'),
('siege'),
('objet'),
('telephone'),
('email'),
('nif'),
('ns'),
('rcs'),
('imagenif'),
('imagercs'),
('imagens'),
('capital'),
('tenue_compte(Ariary)'),
('nb_employ'),
('telecopie');


-- --------------------------------------------------------------------------------
-- insertion devise
insert into devise(nom) values('Ariary');

insert into devise(nom) values('Euros');

-- insertion devise equivalence
insert into devisequivalence(iddevise , taux) values(1 , 10.);

insert into devisequivalence(iddevise , taux) values(2 , 60.);

-- insertion directeur
insert into dirigeant(nom , date , email) values('Rakotomanana' , 'now' , 'rakotomanana@gmail.com');

-- insertion informations
    -- nom
    insert into informations(iddescription , valeur , created_at) values(1 , 'Dimpex' , 'now');

    -- siège
    insert into informations(iddescription , valeur , created_at) values(2 , 'Andoharanoofotsy' , 'now');
    -- objet
    insert into informations(iddescription , valeur , created_at) values(3 , 'production d articles industriels et la vente de marchandises auprès de ces clients locaux et étrangers' , 'now');
    -- téléphone
    insert into informations(iddescription , valeur , created_at) values(4 , '22 770 99' , 'now'); 
    -- email
    insert into informations(iddescription , valeur , created_at) values(5 , 'dimpex@gmail.com' , 'now'); 
    -- nif
    insert into informations(iddescription , valeur , created_at) values(6 , 'nif_1234' , 'now');
    -- ns
    insert into informations(iddescription , valeur , created_at) values(7 , 'ns_1234' , 'now');
    -- rcs
    insert into informations(iddescription , valeur , created_at) values(8 , 'rcs_1234' , 'now');
    -- imagenif
    insert into informations(iddescription , valeur , created_at) values(9 , 'test.png' , 'now');
    -- imagercs
    insert into informations(iddescription , valeur , created_at) values(10 , 'test.png' , 'now');
    -- imagens
    insert into informations(iddescription , valeur , created_at) values(11 , 'test.png' , 'now');
    -- capital
    insert into informations(iddescription , valeur , created_at) values(12 , '5000000000' , 'now');
    -- tenue_compte
    insert into informations(iddescription , valeur , created_at) values(13 , 'Ariary' , 'now');
    -- nb_employé
    insert into informations(iddescription , valeur , created_at) values(14 , '500' , 'now');
    -- télécopie
    insert into informations(iddescription , valeur , created_at) values(15 , '22 230 66' , 'now');

-- insertion journal
insert into journal (code, nom , date) values ('AC' , 'Achats' , 'now');

insert into journal (code, nom , date) values ('AN' , 'A nouveau' , 'now');

insert into journal (code, nom , date) values ('BN' , 'Banque BNI' , 'now');

insert into journal (code, nom , date) values ('BO' , 'Banque BOA' , 'now');

insert into journal (code, nom , date) values ('CA' , 'Caise' , 'now');

insert into journal (code, nom , date) values ('OD' , 'Operations diverses' , 'now');

insert into journal (code, nom , date) values ('VL' , 'Ventes locales' , 'now');

insert into journal (code, nom , date) values ('VE' , 'Ventes à l exploitation' , 'now');

-- insert exercice
insert into exercice (debut) values ('2023-01-01');

-- insertion mois
insert into mois values (01 , 'Janvier');
insert into mois values (02 , 'Fevrier');
insert into mois values (03 , 'Mars');
insert into mois values (04 , 'Avril');
insert into mois values (05 , 'Mais');
insert into mois values (06 , 'Juin');
insert into mois values (07 , 'Juillet');
insert into mois values (08 , 'Aout');
insert into mois values (09 , 'Septembre');
insert into mois values (10 , 'Octobre');
insert into mois values (11 , 'Novembre');
insert into mois values (12 , 'Decembre');


-- insertion compte
insert into compte(numero , libelle) values(41100 , 'clients Andoharanofotsy');

-- insertion tiers
insert into tiers(idcompte , nom) values( (select idcompte from compte where numero = '41100')  , 'TOVO');
insert into tiers(idcompte , nom) values((select idcompte from compte where numero = '41100') , 'TAHINA');
insert into tiers(idcompte , nom) values((select idcompte from compte where numero = '41100') , 'BAOVOLA');
insert into tiers(idcompte , nom) values((select idcompte from compte where numero = '41100') , 'ROJO');
