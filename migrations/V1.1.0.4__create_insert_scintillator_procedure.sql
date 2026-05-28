--up
CREATE OR REPLACE PROCEDURE tgfserver.insert_into_scintillators(new_scintillator TEXT, new_priority INTEGER,
new_color TEXT)
LANGUAGE SQL
AS $$
MERGE INTO tgfserver.scintillators AS s
USING (VALUES (new_scintillator, new_priority, new_color)) AS v(scint_name, scint_priority, plot_color)
ON s.scint_name = v.scint_name
WHEN MATCHED THEN
    UPDATE SET
        scint_priority = v.scint_priority,
        plot_color = v.plot_color
WHEN NOT MATCHED THEN
    INSERT (scint_name, scint_priority, plot_color)
    VALUES (v.scint_name, v.scint_priority, v.plot_color);
$$;

COMMENT ON PROCEDURE tgfserver.insert_into_scintillators
IS 'Procedure that inserts or replaces data in the tgfserver.scintillators table.';

--down
DROP PROCEDURE IF EXISTS tgfserver.insert_into_scintillators;