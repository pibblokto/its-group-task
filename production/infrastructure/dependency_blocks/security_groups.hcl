skip = true


dependency "security_groups" {

  config_path = "..//security_groups"

  mock_outputs = {

    database_security_group_id = "dbsg-00000000"

    application_security_group_id = "appsg-00000000"

    alb_security_group_id = "albsg-00000000"
    
  }
}