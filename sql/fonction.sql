CREATE OR REPLACE FUNCTION getDateFin(date_debut DATE)
RETURNS DATE AS
$$
BEGIN
    RETURN date_debut + INTERVAL '1 year - 1 day';
END;
$$
LANGUAGE plpgsql;

select getDateFin('2023-01-01');


CREATE OR REPLACE FUNCTION getLast_infos()
RETURNS TABLE (idinfo integer , iddescription integer, valeur text, created_at timestamp , description text) AS $$
DECLARE
    id_description INTEGER;
BEGIN
    FOR id_description IN SELECT description.iddescription FROM description LOOP
        RETURN QUERY select informations.idinfo ,
                        informations.iddescription , 
                        informations.valeur , 
                        informations.created_at , 
                        description.description 
                    from informations
                    join description
                    on informations.iddescription = description.iddescription
                    where informations.iddescription = id_description
                    order by informations.created_at desc limit 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;