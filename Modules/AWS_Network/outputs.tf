output "main_vpc_id" {
  value = aws_vpc.main.id
}


output "main_vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}


output "public_subnets_ids" {
  value = aws_subnet.public_subnets[*].id
}


output "private_subnets_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "nat_ip" {
  value = aws_eip.nat_ip.id
}