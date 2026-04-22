--up
CREATE OR REPLACE FUNCTION tgfserver.get_instrument_password(name TEXT) RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    hash TEXT := '';
BEGIN
    SELECT
        client_hash
    INTO hash
    FROM tgfserver.instruments
    WHERE instrument_name = name;

    RETURN hash;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_instrument_password
IS 'Function that returns the password information for the given instrument.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_instrument_password;