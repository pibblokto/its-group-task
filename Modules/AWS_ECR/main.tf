resource "aws_ecr_repository" "ecr" {
  name                 =  var.ecr_name
  image_tag_mutability =  var.tag_mutability
  tags = {
      Name = "${var.project}-${var.environment}-main-ecr"
  }
}