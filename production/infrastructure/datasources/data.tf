data "aws_availability_zones" "available" {}



output "aws_availability_zones_names" {
  value = data.aws_availability_zones.available.names
}
