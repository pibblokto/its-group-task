skip = true


dependency "sns_topic" {

  config_path = "..//sns_topic"

  mock_outputs = {

    sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:example-sns-topic-name"
    
  }
}