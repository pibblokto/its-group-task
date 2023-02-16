#---------- Security Group ----------#
resource "aws_security_group" "security_group" {
  name        = "${var.project}-${var.environment}-${var.security_group_name}"
  description = "${var.project}-${var.environment}-${var.security_group_description}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project}-${var.environment}-${var.security_group_name}"
  }

}




#---------- Ingress rule with CIDR Blocks ----------#
resource "aws_security_group_rule" "ingress_rule_with_cidr" {
  count             = length(var.ingress_with_cidr_rule_from_ports)
  type              = "ingress"
  from_port         = element(var.ingress_with_cidr_rule_from_ports, count.index)
  to_port           = element(var.ingress_with_cidr_rule_to_ports, count.index)
  protocol          = element(var.ingress_with_cidr_rule_protocols, count.index)
  cidr_blocks       = [element(var.ingress_with_cidr_rule_cidr_blocks, count.index)]
  description       = element(var.ingress_with_cidr_rule_description, count.index)
  security_group_id = aws_security_group.security_group.id
}




#---------- Ingress rule with source security group ----------#
resource "aws_security_group_rule" "ingress_rule_with_source_sg" {
  count                    = length(var.ingress_with_source_sg_rule_from_ports)
  type                     = "ingress"
  from_port                = element(var.ingress_with_source_sg_rule_from_ports, count.index)
  to_port                  = element(var.ingress_with_source_sg_rule_to_ports, count.index)
  protocol                 = element(var.ingress_with_source_sg_rule_protocols, count.index)
  source_security_group_id = element(var.ingress_with_source_sg_rule_security_groups, count.index)
  description              = element(var.ingress_with_source_sg_rule_description, count.index)
  security_group_id        = aws_security_group.security_group.id
}





#---------- Egress rule with CIDR Blocks ----------#
resource "aws_security_group_rule" "egress_rule_with_cidr" {
  count             = length(var.egress_with_cidr_rule_from_ports)
  type              = "egress"
  from_port         = element(var.egress_with_cidr_rule_from_ports, count.index)
  to_port           = element(var.egress_with_cidr_rule_to_ports, count.index)
  protocol          = element(var.egress_with_cidr_rule_protocols, count.index)
  cidr_blocks       = [element(var.egress_with_cidr_rule_cidr_blocks, count.index)]
  description       = element(var.egress_with_cidr_rule_description, count.index)
  security_group_id = aws_security_group.security_group.id
}





#---------- Egress rule with source security group ----------#
resource "aws_security_group_rule" "egress_rule_with_source_sg" {
  count                    = length(var.egress_with_source_sg_rule_from_ports)
  type                     = "egress"
  from_port                = element(var.egress_with_source_sg_rule_from_ports, count.index)
  to_port                  = element(var.egress_with_source_sg_rule_to_ports, count.index)
  protocol                 = element(var.egress_with_source_sg_rule_protocols, count.index)
  source_security_group_id = element(var.egress_with_source_sg_rule_security_groups, count.index)
  description              = element(var.egress_with_source_sg_rule_description, count.index)
  security_group_id        = aws_security_group.security_group.id
}
