skip = true


dependency "db_security_group" {

  config_path = "..//db_security_group"

  mock_outputs = {

    database_security_group_id = ["sg-00000002"]
  }
}