--up
CREATE TABLE IF NOT EXISTS tgfserver.general(
    data_root TEXT NOT NULL,
    CONSTRAINT valid_directory_path CHECK(data_root ~ '^((\/[a-zA-Z0-9_-]+)+|\/)$'));

COMMENT ON TABLE tgfserver.general
IS 'A table that stores general data needed by the tgfserver application.';

--down
DROP TABLE IF EXISTS tgfserver.general;