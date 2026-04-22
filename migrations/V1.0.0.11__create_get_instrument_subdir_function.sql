--up
CREATE OR REPLACE FUNCTION tgfserver.get_instrument_subdir(name TEXT) RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    subdir_path TEXT := '';
BEGIN
    SELECT
        subdir
    INTO subdir_path
    FROM tgfserver.instruments
    WHERE instrument_name = name;

    RETURN subdir_path;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_instrument_subdir
IS 'Function that returns the data subdirectory for the given instrument.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_instrument_subdir;