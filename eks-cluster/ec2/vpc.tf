resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16" # Replace with your VPC CIDR block

  tags = {
    Name = "vpc-1"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.16.10.0/24" # Replace with your public subnet CIDR block
  availability_zone       = "us-east-1a"     # Replace with your desired availability zone
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"  # Default route for internet access
  gateway_id             = aws_internet_gateway.gw.id
}