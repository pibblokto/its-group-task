resource "aws_ecr_repository" "ecr" {
  name                 = "${var.project}-${var.environment}-main-ecr"
  image_tag_mutability = var.tag_mutability
  tags = {
    Name = "${var.project}-${var.environment}-main-ecr"
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name
  policy = file(var.policy_json)
}