--up
ALTER TABLE IF EXISTS tgfserver.deployments DROP CONSTRAINT IF EXISTS unique_deployment;

CREATE EXTENSION IF NOT EXISTS btree_gist;

ALTER TABLE IF EXISTS tgfserver.deployments
ADD CONSTRAINT non_overlapping_deployment EXCLUDE USING GIST (
    instrument_id WITH =,
    TSTZRANGE(start_date, end_date) WITH &&);

--down
ALTER TABLE IF EXISTS tgfserver.deployments DROP CONSTRAINT IF EXISTS non_overlapping_deployment;

DROP EXTENSION IF EXISTS btree_gist;

ALTER TABLE IF EXISTS tgfserver.deployments
ADD CONSTRAINT unique_deployment UNIQUE(instrument_id, start_date);