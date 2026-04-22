--up
CREATE OR REPLACE FUNCTION tgfserver.get_check_ins()
    RETURNS TABLE(
        instrument_name TEXT,
        last_check_in TIMESTAMPTZ,
        storage_fraction DOUBLE PRECISION,
        has_gps BOOLEAN)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY

SELECT
    i.instrument_name,
    i.last_check_in,
    i.storage_fraction,
    i.has_gps
FROM tgfserver.instruments AS i
WHERE i.last_check_in IS NOT NULL;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_check_ins
IS 'Function that returns check in information for all instruments.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_check_ins;