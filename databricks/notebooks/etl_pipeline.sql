-- Databricks notebook source
-- MAGIC %python
-- MAGIC import datetime
-- MAGIC
-- MAGIC cur_month = str(datetime.date.today().month)
-- MAGIC cur_year = str(datetime.date.today().year)
-- MAGIC
-- MAGIC spark.sql(f'''
-- MAGIC     CREATE OR REPLACE TEMPORARY VIEW temp_movie_view 
-- MAGIC     AS
-- MAGIC     SELECT *
-- MAGIC     FROM PARQUET.`/mnt/movrec-container/raw/{cur_year}/{cur_month}`;
-- MAGIC     ''')

-- COMMAND ----------

CACHE TABLE temp_movie_view;

-- COMMAND ----------

MERGE INTO movies_dim AS T
USING (
  SELECT movie_id, title, original_language, overview, poster_path 
  FROM (
    SELECT id AS movie_id, title, original_language, overview, poster_path 
    FROM temp_movie_view
  )
) AS S
ON T.movie_id = S.movie_id 
WHEN NOT MATCHED THEN
  INSERT *;

-- COMMAND ----------

MERGE INTO status_fact AS T
USING (
  SELECT date_id, movie_id, popularity, vote_average, vote_count
  FROM (
    SELECT TO_DATE(date, 'dd-MM-yyyy') AS date_id, id AS movie_id, popularity, vote_average, vote_count
    FROM temp_movie_view
  )
) AS S
ON T.date_id = S.date_id AND T.movie_id = S.movie_id
WHEN NOT MATCHED THEN
  INSERT *;

-- COMMAND ----------

SELECT * FROM status_fact;

-- COMMAND ----------

MERGE INTO dates_dim AS T
USING (
  SELECT date_id 
  FROM (
    SELECT TO_DATE(date, 'dd-MM-yyyy') AS date_id
    FROM temp_movie_view
  )
) AS S
ON T.date_id = S.date_id 
WHEN NOT MATCHED THEN
  INSERT (date_id) VALUES (S.date_id);

-- COMMAND ----------

MERGE INTO movies_gernes AS T
USING (
  SELECT movie_id, genre_id 
  FROM (
    SELECT id AS movie_id, explode(genre_ids) AS genre_id 
    FROM temp_movie_view
  )
) AS S
ON T.movie_id = S.movie_id AND T.gerne_id = S.genre_id
WHEN NOT MATCHED THEN
  INSERT (movie_id, gerne_id) VALUES (S.movie_id, S.genre_id);

-- COMMAND ----------

CREATE OR REPLACE TEMPORARY VIEW temp_meta_view 
AS
SELECT *
FROM parquet.`/mnt/movrec-container/meta/gernes`;

-- COMMAND ----------

SELECT * FROM temp_meta_view;

-- COMMAND ----------

MERGE INTO gernes_dim AS T
USING (
  SELECT gerne_id, gerne
  FROM (
    SELECT id AS gerne_id, name AS gerne
    FROM temp_meta_view
  )
) AS S
ON T.gerne_id = S.gerne_id AND T.gerne = S.gerne
WHEN NOT MATCHED BY SOURCE THEN
  UPDATE SET T.gerne_id = gerne_id, T.gerne = gerne;
