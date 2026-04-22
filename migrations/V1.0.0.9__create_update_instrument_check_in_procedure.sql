--up
CREATE OR REPLACE PROCEDURE tgfserver.update_instrument_check_in(instrument TEXT, storage DOUBLE PRECISION, gps BOOLEAN)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.instruments AS i
USING (VALUES (instrument, storage, gps)) AS v(instrument_name, storage_fraction, has_gps)
ON i.instrument_name = v.instrument_name
WHEN MATCHED THEN
    UPDATE SET
        last_check_in = NOW(),
        storage_fraction = v.storage_fraction,
        has_gps = v.has_gps
WHEN NOT MATCHED THEN
    DO NOTHING;
$$;

COMMENT ON PROCEDURE tgfserver.update_instrument_check_in
IS 'Procedure that updates the check in information in the tgfserver.instruments table for the given instrument.';

--down
DROP PROCEDURE IF EXISTS tgfserver.update_instrument_check_in;