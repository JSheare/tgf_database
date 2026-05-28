--up
CREATE OR REPLACE FUNCTION tgfserver.get_config(name TEXT, target_date TIMESTAMPTZ)
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

    WITH possible_configs AS (
        SELECT
            c.after_date,
            MAX(c.after_date) OVER() AS max_date,
            s.scint_name,
            c.erc,
            f.format_name,
            c.long_event_search
        FROM tgfserver.configurations AS c
            JOIN tgfserver.instruments AS i USING (instrument_id)
            JOIN tgfserver.scintillators AS s USING (scint_id)
            JOIN tgfserver.lm_formats AS f USING (format_id)
        WHERE i.instrument_name = name AND target_date >= c.after_date
    )
    SELECT
        p.after_date,
        p.scint_name,
        p.erc,
        p.format_name,
        p.long_event_search
    FROM possible_configs AS p
    WHERE p.after_date = p.max_date;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_config
IS 'Function that returns the config info for the specified instrument on the specified date.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_config;