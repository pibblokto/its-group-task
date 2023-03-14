skip = true


dependency "app_security_group" {

  config_path  = "..//app_security_group"

  mock_outputs = {

    security_group_id = "sg-00000001"
  }
}