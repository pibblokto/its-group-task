skip = true


dependency "s3" {

  config_path  = "..//s3"

  mock_outputs = {

    s3_bucket_arn                = "arn:aws:s3:::random-bucket-name"

    s3_bucket_bucket_domain_name = "random-name.s3.us-east-1.amazonaws.com"

    s3_bucket_id                 = "random-s3-bucket-id"
    
  }
}