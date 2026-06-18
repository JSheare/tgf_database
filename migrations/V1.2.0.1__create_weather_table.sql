--up
CREATE TABLE IF NOT EXISTS tgfserver.weather(
    deployment_id INTEGER REFERENCES tgfserver.deployments (deployment_id) ON DELETE CASCADE NOT NULL,
    measurement_time TIMESTAMPTZ NOT NULL,
    condition TEXT NOT NULL,
    CONSTRAINT unique_measurement UNIQUE(deployment_id, measurement_time));

CREATE INDEX IF NOT EXISTS deployment_id_index
ON tgfserver.weather(deployment_id);

COMMENT ON TABLE tgfserver.weather
IS 'A table that stores weather information for the deployments of the TGF group.';

--down
DROP TABLE IF EXISTS tgfserver.weather;