skip = true


dependency "alb" {

  config_path = "..//alb"

  mock_outputs = {

    target_group_arns = ["arn:aws:elasticloadbalancing:us-east-1:111122223333:targetgroup/random-name/random-id"]

    lb_dns_name = "example-dns.com"
    
  }
}