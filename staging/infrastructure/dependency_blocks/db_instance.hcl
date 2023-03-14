skip = true


dependency "db_instance" {

  config_path  = "..//db_instance"

  mock_outputs = {

    db_instance_endpoint = "random-db-name.symbols.us-east-1.rds.amazonaws.com"
    
  }
}