--up
CREATE OR REPLACE FUNCTION tgfserver.get_format_id(name TEXT) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := NULL;
BEGIN
    SELECT
        format_id
    INTO id
    FROM tgfserver.lm_formats
    WHERE format_name = name;

    RETURN id;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_format_id
IS 'Function that returns the id for the given list mode data format.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_format_id;