skip = true


dependency "db_instance" {

  config_path = "..//db_instance"

  mock_outputs = {

    db_instance_id = "dbid-00000000"
    
  }
}