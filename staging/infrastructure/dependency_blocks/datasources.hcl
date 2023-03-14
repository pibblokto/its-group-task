skip = true


dependency "datasources" {

  config_path  = "..//datasources"

  mock_outputs = {

    aws_availability_zones_names = [

    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e",
    "us-east-1f"  

    ]

    postgres_db       = "secret0"

    database_username = "secret1"

    database_password = "secret2"

  }
}
