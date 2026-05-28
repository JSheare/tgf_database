--up
CREATE OR REPLACE FUNCTION tgfserver.get_all_configs(name TEXT)
    RETURNS TABLE(
        after_date TIMESTAMPTZ,
        scint_name TEXT,
        erc TEXT,
        format_name TEXT,
        long_event_search BOOL)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY

    SELECT
        c.after_date,
        s.scint_name,
        c.erc,
        f.format_name,
        c.long_event_search
    FROM tgfserver.configurations AS c
        JOIN tgfserver.instruments AS i USING (instrument_id)
        JOIN tgfserver.scintillators AS s USING (scint_id)
        JOIN tgfserver.lm_formats AS f USING (format_id)
    WHERE i.instrument_name = name;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_all_configs
IS 'Function that returns the all config info for the specified instrument.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_all_configs;