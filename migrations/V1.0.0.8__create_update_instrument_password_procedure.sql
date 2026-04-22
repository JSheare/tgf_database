--up
CREATE OR REPLACE PROCEDURE tgfserver.update_instrument_password(instrument TEXT, hash TEXT)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.instruments AS i
USING (VALUES (instrument, hash)) AS v(instrument_name, client_hash)
ON i.instrument_name = v.instrument_name
WHEN MATCHED THEN
    UPDATE SET
        client_hash = v.client_hash
WHEN NOT MATCHED THEN
    DO NOTHING;
$$;

COMMENT ON PROCEDURE tgfserver.update_instrument_password
IS 'Procedure that updates the password in the tgfserver.instruments table for the given instrument.';

--down
DROP PROCEDURE IF EXISTS tgfserver.update_instrument_password;