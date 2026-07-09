--up
CREATE OR REPLACE FUNCTION tgfserver.get_weather(instrument TEXT, target_date TIMESTAMPTZ)
    RETURNS TABLE(
        measurement_time TIMESTAMPTZ,
        condition TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := tgfserver.get_deployment_id(instrument, target_date);
BEGIN
    RETURN QUERY

    SELECT
        w.measurement_time,
        w.condition
    FROM tgfserver.weather AS w
    WHERE
        w.deployment_id = id
        AND w.measurement_time >= DATE_TRUNC('day', target_date)
        AND w.measurement_time < DATE_TRUNC('day', target_date) + '1 day'::INTERVAL
    ORDER BY w.measurement_time;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_weather
IS 'Function that returns weather info for the specified instrument on the specified date.';

--down
CREATE OR REPLACE FUNCTION tgfserver.get_weather(instrument TEXT, target_date TIMESTAMPTZ)
    RETURNS TABLE(
        measurement_time TIMESTAMPTZ,
        condition TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := tgfserver.get_deployment_id(instrument, target_date);
BEGIN
    RETURN QUERY

    SELECT
        w.measurement_time,
        w.condition
    FROM tgfserver.weather AS w
    WHERE
        w.deployment_id = id
        AND w.measurement_time >= DATE_TRUNC('day', target_date)
        AND w.measurement_time < DATE_TRUNC('day', target_date) + '1 day'::INTERVAL;

END;
$$;

COMMENT ON FUNCTION tgfserver.get_weather
IS 'Function that returns weather info for the specified instrument on the specified date.';