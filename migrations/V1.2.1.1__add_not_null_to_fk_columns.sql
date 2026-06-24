--up
ALTER TABLE tgfserver.configurations ALTER COLUMN instrument_id SET NOT NULL;

ALTER TABLE tgfserver.configurations ALTER COLUMN scint_id SET NOT NULL;

ALTER TABLE tgfserver.configurations ALTER COLUMN format_id SET NOT NULL;

ALTER TABLE tgfserver.deployments ALTER COLUMN instrument_id SET NOT NULL;


--down
ALTER TABLE tgfserver.configurations ALTER COLUMN instrument_id DROP NOT NULL;

ALTER TABLE tgfserver.configurations ALTER COLUMN scint_id DROP NOT NULL;

ALTER TABLE tgfserver.configurations ALTER COLUMN format_id DROP NOT NULL;

ALTER TABLE tgfserver.deployments ALTER COLUMN instrument_id DROP NOT NULL;
