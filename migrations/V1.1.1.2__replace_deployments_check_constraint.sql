--up
ALTER TABLE IF EXISTS tgfserver.deployments DROP CONSTRAINT IF EXISTS positive_range;

ALTER TABLE IF EXISTS tgfserver.deployments ADD CONSTRAINT positive_range CHECK(start_date <= end_date);

--down
ALTER TABLE IF EXISTS tgfserver.deployments DROP CONSTRAINT IF EXISTS positive_range;

ALTER TABLE IF EXISTS tgfserver.deployments ADD CONSTRAINT positive_range CHECK(start_date < end_date);