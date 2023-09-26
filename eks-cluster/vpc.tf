# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create public subnet
# Create public subnets
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Create private subnets
resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = element(["10.0.3.0/24", "10.0.4.0/24"], count.index)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_vpc" "node-vpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "node-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public-node" {
  count            = 2
  vpc_id           = aws_vpc.node-vpc.id
  cidr_block       = "192.168.${count.index + 1}.0/24"  # Change the CIDR blocks as needed
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "node-public-subnet-${count.index}"
  }
}

# Create private subnets
resource "aws_subnet" "private-node" {
  count            = 2
  vpc_id           = aws_vpc.node-vpc.id
  cidr_block       = "192.168.${count.index + 3}.0/24"  # Change the CIDR blocks as needed
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  tags = {
    Name = "node-private-subnet-${count.index}"
  }
}
