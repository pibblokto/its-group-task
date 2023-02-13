skip = true


dependency "vpc" {

  config_path = "..//vpc"

  mock_outputs = {

    main_vpc_id = "vpc-00000000"
    
    private_subnets_ids = [
      "subnet-00000000",
      "subnet-00000001",
      "subnet-00000002"
    ]
  }
}