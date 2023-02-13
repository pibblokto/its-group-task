resource "aws_sns_topic" "rds_events_sns_topic" {
  name         = "${var.project}-${var.environment}-RDS-Events-Topic"
  display_name = var.display_name
  fifo_topic   = var.fifo_topic

  tags = {
    Name = "${var.project}-${var.environment}-RDS-Events-Topic"
  }
}

resource "aws_sns_topic_subscription" "rds_events_subscription" {
  count     = length(var.sns_topic_subscribers)
  topic_arn = aws_sns_topic.rds_events_sns_topic.arn
  protocol  = var.sns_topic_subscription_protocol
  endpoint  = element(var.sns_topic_subscribers, count.index)
}
