--up
CREATE OR REPLACE FUNCTION tgfserver.get_deployment(name TEXT, target_date TIMESTAMPTZ)
    RETURNS TABLE(
        start_date TIMESTAMPTZ,
        end_date TIMESTAMPTZ,
        location TEXT,
        tz_identifier TEXT,
        weather_station TEXT,
        sounding_station TEXT,
        latitude DOUBLE PRECISION,
        longitude DOUBLE PRECISION,
        altitude DOUBLE PRECISION,
        notes TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY

    SELECT
        d.start_date,
        d.end_date,
        d.location,
        d.tz_identifier,
        d.weather_station,
        d.sounding_station,
        d.latitude,
        d.longitude,
        d.altitude,
        d.notes
    FROM tgfserver.deployments AS d
        JOIN tgfserver.instruments AS i USING (instrument_id)
    WHERE i.instrument_name = name AND target_date >= d.start_date AND target_date <= d.end_date;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_deployment
IS 'Function that returns the deployment for the specified instrument on the specified date.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_deployment;