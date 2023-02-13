output "sns_topic_id" {
  value = aws_sns_topic.rds_events_sns_topic.id
}

output "sns_topic_arn" {
  value = aws_sns_topic.rds_events_sns_topic.arn
}

output "sns_topic_subscription_arn" {
  value = aws_sns_topic_subscription.rds_events_subscription[*].arn
}

output "sns_topic_subscription_confirmation" {
  value = aws_sns_topic_subscription.rds_events_subscription[*].pending_confirmation
}
