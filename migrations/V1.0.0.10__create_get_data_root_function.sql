--up
CREATE OR REPLACE FUNCTION tgfserver.get_data_root() RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    root TEXT := '';
BEGIN
    SELECT
        data_root
    INTO root
    FROM tgfserver.general;

    RETURN root;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_data_root
IS 'Function that returns the absolute path to all TGF Group data on the main data computer.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_data_root;