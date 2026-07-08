--up
CREATE OR REPLACE FUNCTION tgfserver.get_deployment_id(name TEXT, target_date TIMESTAMPTZ) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := NULL;
BEGIN
    SELECT
        d.deployment_id
    INTO id
    FROM tgfserver.deployments AS d
        JOIN tgfserver.instruments AS i USING (instrument_id)
    WHERE i.instrument_name = name AND DATE_TRUNC('day', target_date) >= DATE_TRUNC('day', d.start_date)
        AND DATE_TRUNC('day', target_date) <= DATE_TRUNC('day', d.end_date);

    RETURN id;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_instrument_id
IS 'Function that returns the deployment id for the given instrument and date.';

--down
CREATE OR REPLACE FUNCTION tgfserver.get_deployment_id(name TEXT, target_date TIMESTAMPTZ) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := NULL;
BEGIN
    SELECT
        d.deployment_id
    INTO id
    FROM tgfserver.deployments AS d
        JOIN tgfserver.instruments AS i USING (instrument_id)
    WHERE i.instrument_name = name AND target_date >= d.start_date AND target_date <= d.end_date;

    RETURN id;
END;
$$;

COMMENT ON FUNCTION tgfserver.get_instrument_id
IS 'Function that returns the deployment id for the given instrument and date.';