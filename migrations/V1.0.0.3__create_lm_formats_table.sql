--up
CREATE TABLE IF NOT EXISTS tgfserver.lm_formats(
    format_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    format_name TEXT UNIQUE NOT NULL);

COMMENT ON TABLE tgfserver.lm_formats
IS 'A table that stores the names of list mode data file formats.';

--down
DROP TABLE IF EXISTS tgfserver.lm_formats;