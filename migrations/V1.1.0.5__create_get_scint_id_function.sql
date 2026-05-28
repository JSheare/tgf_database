--up
CREATE OR REPLACE FUNCTION tgfserver.get_scint_id(name TEXT) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := NULL;
BEGIN
    SELECT
        scint_id
    INTO id
    FROM tgfserver.scintillators
    WHERE scint_name = name;

    RETURN id;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_scint_id
IS 'Function that returns the id for the given scintillator.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_scint_id;