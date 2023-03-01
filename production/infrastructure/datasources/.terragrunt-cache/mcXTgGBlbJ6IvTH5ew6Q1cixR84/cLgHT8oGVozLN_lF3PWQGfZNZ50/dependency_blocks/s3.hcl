skip = true


dependency "s3" {

  config_path = "..//s3"

  mock_outputs = {

    s3_bucket_arn = "arn:aws:s3:::random-bucket-name"
    
  }
}