--up
CREATE OR REPLACE FUNCTION tgfserver.get_instrument_id(name TEXT) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := NULL;
BEGIN
    SELECT
        instrument_id
    INTO id
    FROM tgfserver.instruments
    WHERE instrument_name = name;

    RETURN id;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_instrument_id
IS 'Function that returns the id for the given instrument.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_instrument_id;