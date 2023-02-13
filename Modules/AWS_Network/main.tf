### Data ###

data "aws_availability_zones" "alive" {
  state = "available"
}

locals {
  az_amount = length(data.aws_availability_zones.alive.names)
}

### VPC ###

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project}-${var.environment}-main-vpc"
  }
}

### Subnets ###

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = data.aws_availability_zones.alive.names[count.index % local.az_amount]
  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-${count.index + 1}"

  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnets)
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = data.aws_availability_zones.alive.names[count.index % local.az_amount]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.project}-${var.environment}-public-subnet-${count.index + 1}"

  }
}

### Gateways ###

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-${var.environment}-igw"
  }
}

resource "aws_eip" "nat_ip" {
  tags = {
    Name = "${var.project}-${var.environment}-elastic-ip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.project}-${var.environment}-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

### Route tables ###

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project}-${var.environment}-private-route-table"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-${var.environment}-public-route-table"
  }
}

### Route tables associations ###

resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
