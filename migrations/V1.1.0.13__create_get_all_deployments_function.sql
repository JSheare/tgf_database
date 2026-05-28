--up
CREATE OR REPLACE FUNCTION tgfserver.get_all_deployments(name TEXT)
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
    WHERE i.instrument_name = name;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_all_deployments
IS 'Function that returns all deployments for the specified instrument.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_all_deployments;