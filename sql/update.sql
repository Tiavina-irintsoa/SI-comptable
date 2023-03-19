UPDATE compte SET numero = numero::text || '0' || repeat('0', 4 - length(numero::text));

UPDATE compte SET numero = regexp_replace(numero::text, '0*$', '')::integer;
