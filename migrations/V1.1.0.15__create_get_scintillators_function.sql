--up
CREATE OR REPLACE FUNCTION tgfserver.get_scintillators()
    RETURNS TABLE(
        scint_name TEXT,
        scint_priority INTEGER,
        plot_color TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY

    SELECT
        s.scint_name,
        s.scint_priority,
        s.plot_color
    FROM tgfserver.scintillators AS s;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_scintillators
IS 'Function that returns the information for all existent scintillators';

--down
DROP FUNCTION IF EXISTS tgfserver.get_scintillators;