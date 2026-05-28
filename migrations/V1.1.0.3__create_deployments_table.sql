--up
CREATE TABLE IF NOT EXISTS tgfserver.deployments(
    deployment_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    instrument_id INTEGER REFERENCES tgfserver.instruments (instrument_id) ON DELETE CASCADE,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    location TEXT DEFAULT 'unknown' NOT NULL,
    tz_identifier TEXT DEFAULT 'UTC' NOT NULL,
    weather_station TEXT NOT NULL,
    sounding_station TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    altitude DOUBLE PRECISION,
    notes TEXT,
    CONSTRAINT positive_range CHECK(start_date < end_date),
    CONSTRAINT unique_deployment UNIQUE(instrument_id, start_date));

CREATE INDEX IF NOT EXISTS instrument_id_index
ON tgfserver.deployments(instrument_id);

COMMENT ON TABLE tgfserver.instruments
IS 'A table that stores deployment information for the instruments of the TGF group.';

--down
DROP TABLE IF EXISTS tgfserver.deployments;