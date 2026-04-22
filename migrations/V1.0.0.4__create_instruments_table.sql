--up
CREATE TABLE IF NOT EXISTS tgfserver.instruments(
    instrument_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    instrument_name TEXT UNIQUE NOT NULL,
    subdir TEXT NOT NULL,
    client_hash TEXT,
    last_check_in TIMESTAMPTZ,
    storage_fraction DOUBLE PRECISION,
    has_gps BOOLEAN,
    CONSTRAINT valid_subdirectory_path CHECK(subdir ~ '^[a-zA-Z0-9_-]+(\/[a-zA-Z0-9_-]+)*$'),
    CONSTRAINT defined_check_in CHECK(
        (last_check_in IS NULL AND storage_fraction IS NULL AND has_gps IS NULL) OR
        (last_check_in IS NOT NULL AND storage_fraction IS NOT NULL AND has_gps IS NOT NULL)));

CREATE INDEX IF NOT EXISTS instrument_name_index
ON tgfserver.instruments(instrument_name);

COMMENT ON TABLE tgfserver.instruments
IS 'A table that stores basic information about the instruments of the TGF group.';

--down
DROP TABLE IF EXISTS tgfserver.instruments;