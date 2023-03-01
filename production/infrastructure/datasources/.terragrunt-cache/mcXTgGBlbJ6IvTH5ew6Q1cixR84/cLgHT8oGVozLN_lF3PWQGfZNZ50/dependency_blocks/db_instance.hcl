skip = true


dependency "db_instance" {

  config_path = "..//db_instance"

  mock_outputs = {

    database_instance_id = "dbid-00000000"
    
  }
}