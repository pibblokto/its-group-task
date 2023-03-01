skip = true


dependency "vpc" {

  config_path = "..//vpc"

  mock_outputs = {

    vpc_id = "vpc-00000000"
    
    private_subnets = [
      "subnet-00000000",
      "subnet-00000001"
    ]

    public_subnets = [
      "subnet-00000003",
      "subnet-00000004"
    ]
  }
}