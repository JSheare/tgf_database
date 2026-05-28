--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_configurations(new_instrument TEXT, new_after_date TIMESTAMPTZ,
new_scint_name TEXT, new_erc TEXT, new_format_name TEXT, new_long_event_search BOOL)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.configurations AS c
USING
    (VALUES (tgfserver.get_instrument_id(new_instrument), new_after_date, tgfserver.get_scint_id(new_scint_name),
    new_erc, tgfserver.get_format_id(new_format_name), new_long_event_search))
    AS v(instrument_id, after_date, scint_id, erc, format_id, long_event_search)
ON
    c.instrument_id = v.instrument_id
    AND c.after_date = v.after_date
    AND c.scint_id = v.scint_id
    AND c.erc = v.erc
    AND c.format_id = v.format_id
WHEN MATCHED THEN
    UPDATE SET
        long_event_search = v.long_event_search
WHEN NOT MATCHED THEN
    INSERT (instrument_id, after_date, scint_id, erc, format_id, long_event_search)
    VALUES (v.instrument_id, v.after_date, v.scint_id, v.erc, v.format_id, v.long_event_search)
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_configurations
IS 'Procedure that inserts or replaces data in the tgfserver.configurations table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_configurations;