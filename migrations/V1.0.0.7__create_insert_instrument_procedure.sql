--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_instruments(new_instrument TEXT, new_subdir TEXT)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.instruments AS i
USING (VALUES (new_instrument, new_subdir)) AS v(instrument_name, subdir)
ON i.instrument_name = v.instrument_name
WHEN MATCHED THEN
    UPDATE SET
        subdir = v.subdir
WHEN NOT MATCHED THEN
    INSERT (instrument_name, subdir)
    VALUES (v.instrument_name, v.subdir);
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_instruments
IS 'Procedure that inserts or replaces general data in the tgfserver.instruments table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_instruments;