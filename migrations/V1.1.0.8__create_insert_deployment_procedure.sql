--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_deployments(new_instrument TEXT, new_start_date TIMESTAMPTZ,
new_end_date TIMESTAMPTZ, new_location TEXT, new_tz_identifier TEXT, new_weather_station TEXT,
new_sounding_station TEXT, new_latitude DOUBLE PRECISION, new_longitude DOUBLE PRECISION, new_altitude DOUBLE PRECISION,
new_notes TEXT)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.deployments AS d
USING
    (VALUES (tgfserver.get_instrument_id(new_instrument), new_start_date, new_end_date, new_location, new_tz_identifier,
    new_weather_station, new_sounding_station, new_latitude, new_longitude, new_altitude, new_notes))
    AS v(instrument_id, start_date, end_date, location, tz_identifier, weather_station, sounding_station, latitude,
    longitude, altitude, notes)
ON d.instrument_id = v.instrument_id AND d.start_date = v.start_date
WHEN MATCHED THEN
    UPDATE SET
        location = v.location,
        tz_identifier = v.tz_identifier,
        weather_station = v.weather_station,
        sounding_station = v.sounding_station,
        latitude = v.latitude,
        longitude = v.longitude,
        altitude = v.altitude,
        notes = v.notes
WHEN NOT MATCHED THEN
    INSERT (instrument_id, start_date, end_date, location, tz_identifier, weather_station, sounding_station, latitude,
    longitude, altitude, notes)
    VALUES (v.instrument_id, v.start_date, v.end_date, v.location, v.tz_identifier, v.weather_station,
    v.sounding_station, v.latitude, v.longitude, v.altitude, v.notes)
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_deployments
IS 'Procedure that inserts or replaces data in the tgfserver.deployments table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_deployments;