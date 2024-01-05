data "databricks_current_user" "me" {
}

resource "databricks_notebook" "init_table_schema" {
  source = "../databricks/notebooks/init_table_schema.sql"
  path   = "${data.databricks_current_user.me.home}/once/init_table_schema"
}

resource "databricks_notebook" "fetch_daily_data" {
  source = "../databricks/notebooks/fetch_daily_data.ipynb"
  path   = "${data.databricks_current_user.me.home}/daily/fetch_daily_data"
}

resource "databricks_notebook" "fetch_weekly_meta_data" {
  source = "../databricks/notebooks/fetch_weekly_meta_data.ipynb"
  path   = "${data.databricks_current_user.me.home}/weekly/fetch_weekly_meta_data"
}

resource "databricks_notebook" "etl_pipeline" {
  source = "../databricks/notebooks/etl_pipeline.sql"
  path   = "${data.databricks_current_user.me.home}/weekly/etl_pipeline"
}

resource "databricks_job" "once" {
  name = "once"

  task {
    task_key            = "a"
    existing_cluster_id = databricks_cluster.this.id
    notebook_task {
      notebook_path = "${data.databricks_current_user.me.home}/once/init_table_schema"
    }
  }
}

resource "databricks_job" "daily" {
  name = "daily"

  task {
    task_key            = "a"
    existing_cluster_id = databricks_cluster.this.id
    notebook_task {
      notebook_path = "${data.databricks_current_user.me.home}/daily/fetch_daily_data"
    }
  }

  schedule {
    quartz_cron_expression = "0 0 0 * * ?"
    timezone_id            = "Europe/Helsinki"
  }
}

resource "databricks_job" "weekly" {
  name = "weekly"

  task {
    task_key            = "a"
    existing_cluster_id = databricks_cluster.this.id
    notebook_task {
      notebook_path = "${data.databricks_current_user.me.home}/weekly/fetch_weekly_meta_data"
    }
  }

  task {
    task_key            = "b"
    existing_cluster_id = databricks_cluster.this.id
    notebook_task {
      notebook_path = "${data.databricks_current_user.me.home}/weekly/etl_pipeline"
    }
  }


  schedule {
    quartz_cron_expression = "0 5 0 * * ?"
    timezone_id            = "Europe/Helsinki"
  }
}
