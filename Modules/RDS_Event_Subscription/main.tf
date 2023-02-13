resource "aws_db_event_subscription" "database_event_subscription" {
  name      = "${var.project}-${var.environment}-rds-event-subscription"
  sns_topic = var.sns_topic

  source_type = var.source_type
  source_ids  = var.source_ids

  enabled = var.enabled

  event_categories = var.event_categories

  tags = {
    Name = "${var.project}-${var.environment}-rds-event-subscription"
  }
}
