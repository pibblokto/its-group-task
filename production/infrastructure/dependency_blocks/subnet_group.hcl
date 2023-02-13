skip = true


dependency "subnet_group" {

  config_path = "..//subnet_group"

  mock_outputs = {

    subnet_group_id = "subg-00000000"
    
  }
}