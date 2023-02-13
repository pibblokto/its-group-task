output "main_vpc_id" {
  value = aws_vpc.terra_main_vpc.id
}


output "main_vpc_cidr_block" {
  value = aws_vpc.terra_main_vpc.cidr_block
}


output "public_subnets_ids" {
  value = aws_subnet.public_subnets[*].id
}


output "private_subnets_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}