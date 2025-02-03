set statement_timeout to 600000;

CREATE OR REPLACE FUNCTION one_shot_events()
RETURNS void AS $$
DECLARE
  procedure procedures;
  start_time timestamp := clock_timestamp();
  end_time timestamp;
  execution_time interval;
  i INT := 0;
BEGIN
RAISE LOG 'Processing One shot events';
  UPDATE procedures
    SET status = null;

  FOR procedure IN
    SELECT *
    FROM procedures
    WHERE is_principale IS TRUE
  LOOP
  i := i + 1;
  RAISE LOG 'Processing procedure events N: %', i;
  PERFORM set_procedure_status(procedure);
  END LOOP;

  end_time := clock_timestamp();
  execution_time := end_time - start_time;
  RAISE LOG 'FUNCTION ONE SHOT execution time: %', execution_time;
END;
$$ LANGUAGE plpgsql;
