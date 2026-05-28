--up
CREATE TABLE IF NOT EXISTS tgfserver.scintillators(
    scint_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    scint_name TEXT UNIQUE NOT NULL,
    scint_priority INTEGER NOT NULL,
    plot_color TEXT NOT NULL);

CREATE INDEX IF NOT EXISTS scint_name_index
ON tgfserver.scintillators(scint_name);

COMMENT ON TABLE tgfserver.scintillators
IS 'A table that stores basic information about the scintillator types of the TGF group.';

--down
DROP TABLE IF EXISTS tgfserver.scintillators;