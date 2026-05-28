--up
CREATE OR REPLACE FUNCTION tgfserver.get_instruments()
    RETURNS TABLE(
        instrument_name TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY

    SELECT
        i.instrument_name
    FROM tgfserver.instruments AS i;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_instruments
IS 'Function that returns a list of all existent instruments';

--down
DROP FUNCTION IF EXISTS tgfserver.get_instruments;