--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_weather(instrument TEXT, new_measurement_time TIMESTAMPTZ,
new_condition TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    id INTEGER := tgfserver.get_deployment_id(instrument, new_measurement_time);

BEGIN
    IF id IS NOT NULL THEN
        INSERT INTO tgfserver.weather (deployment_id, measurement_time, condition)
        VALUES (id, new_measurement_time, new_condition);
    END IF;
END;
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_weather
IS 'Procedure that inserts data into the tgfserver.weather table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_weather;