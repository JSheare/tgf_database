--up
CREATE TABLE IF NOT EXISTS tgfserver.configurations(
    instrument_id INTEGER REFERENCES tgfserver.instruments (instrument_id) ON DELETE CASCADE,
    after_date TIMESTAMPTZ NOT NULL,
    scint_id INTEGER REFERENCES tgfserver.scintillators (scint_id) ON DELETE CASCADE,
    erc TEXT NOT NULL,
    format_id INTEGER REFERENCES tgfserver.lm_formats (format_id) ON DELETE CASCADE,
    long_event_search BOOL DEFAULT FALSE NOT NULL,
    CONSTRAINT unique_configuration UNIQUE(instrument_id, after_date, scint_id, erc, format_id));

CREATE INDEX IF NOT EXISTS instrument_id_index
ON tgfserver.configurations(instrument_id);

COMMENT ON TABLE tgfserver.configurations
IS 'A table that stores scintillator configuration information for the instruments of the TGF group.';

--down
DROP TABLE IF EXISTS tgfserver.configurations;