alter table description add column inputType varchar;
update description set inputType='text';
update description set inputType='file' where description='imagenif' or description='imagercs' or description='imagens';
insert into description (description,inputType) values('logo','file');


novaina:
-informationsmodel
-dossier js 
-headform
-head 
-ajoutcompte 
-ajouttiers
-ajoutdevise
-ajoutjournal
-journal
-devise
-compte
-tiers
-Model 4
-Controllers 4
-modif rehetra
-informations
-base