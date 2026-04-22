--up
CREATE SCHEMA IF NOT EXISTS tgfserver;

COMMENT ON SCHEMA tgfserver
IS 'Schema for the tgfserver application.'

--down
DROP SCHEMA IF EXISTS tgfserver;