--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_lm_formats(new_format_name TEXT)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.lm_formats AS l
USING (VALUES (new_format_name)) AS v(format_name)
ON l.format_name = v.format_name
WHEN MATCHED THEN
    DO NOTHING
WHEN NOT MATCHED THEN
    INSERT (format_name)
    VALUES (v.format_name);
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_lm_formats
IS 'Procedure that inserts data into the tgfserver.lm_formats table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_lm_formats;