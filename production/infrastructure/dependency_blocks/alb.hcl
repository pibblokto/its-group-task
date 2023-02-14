skip = true


dependency "alb" {

  config_path = "..//alb"

  mock_outputs = {

    alb_target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:111122223333:targetgroup/random-name/random-id"
    
  }
}