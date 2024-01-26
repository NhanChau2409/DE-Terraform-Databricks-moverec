-- Databricks notebook source
CREATE TABLE IF NOT EXISTS movies_dim (
  movie_id INT NOT NULL,
	title STRING,
	original_language STRING,
	overview STRING,
	poster_path STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS status_fact (
  movie_id INT NOT NULL,
	date_id DATE NOT NULL,
	popularity FLOAT,
	vote_average FLOAT,
	vote_count INT
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS gernes_dim (
  gerne_id INT NOT NULL,
  gerne STRING NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS movies_gernes(
  movie_id INT NOT NULL,
  gerne_id INT NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS dates_dim(
  date_id DATE NOT NULL,
  day INT GENERATED ALWAYS AS (DAY(date_id)),
  month INT GENERATED ALWAYS AS (MONTH(date_id)),
  year INT GENERATED ALWAYS AS (YEAR(date_id))
);

-- COMMAND ----------

SHOW TABLES IN default
