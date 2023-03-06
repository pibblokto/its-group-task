skip = true


dependency "alb_security_group" {

  config_path  = "..//alb_security_group"

  mock_outputs = {

    security_group_id = "sg-00000000"
  }
}