--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_general(new_data_root TEXT)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.general AS g
USING (VALUES (new_data_root)) AS v(data_root)
ON g.data_root LIKE '%'
WHEN MATCHED THEN
    UPDATE SET
        data_root = v.data_root
WHEN NOT MATCHED THEN
    INSERT (data_root)
    VALUES (v.data_root);
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_general
IS 'Procedure that inserts or replaces data in the tgfserver.general table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_general;