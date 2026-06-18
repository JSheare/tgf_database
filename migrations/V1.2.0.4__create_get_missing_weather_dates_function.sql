--up
CREATE OR REPLACE FUNCTION tgfserver.get_missing_weather_dates(instrument TEXT, start_date TIMESTAMPTZ,
end_date TIMESTAMPTZ)
    RETURNS TABLE(
        missing_date TIMESTAMPTZ)
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := tgfserver.get_deployment_id(instrument, start_date);
BEGIN
    RETURN QUERY

    SELECT
        weather_date
    FROM generate_series(DATE_TRUNC('day', start_date), DATE_TRUNC('day', end_date), '1 day'::INTERVAL) AS weather_date
    WHERE weather_date NOT IN (
            SELECT
                DISTINCT DATE_TRUNC('day', measurement_time)
            FROM tgfserver.weather
            WHERE deployment_id = id)
    ORDER BY weather_date;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_missing_weather_dates
IS 'Function that returns the missing weather dates for the given instrument on the given range.';

--down
DROP FUNCTION IF EXISTS tgfserver.get_missing_weather_dates;