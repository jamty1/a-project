resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "dev_subnet_a" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Development Subnet A"
  }
}

resource "aws_subnet" "dev_subnet_b" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Development Subnet B"
  }
}

resource "aws_subnet" "dev_subnet_c" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Development Subnet C"
  }
}


resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "rtable" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Route Table"
  }
}

# Opens subnet A to the internet, allows public access for the EC2 instance
resource "aws_route_table_association" "rtable_a" {
  subnet_id      = aws_subnet.dev_subnet_a.id
  route_table_id = aws_route_table.rtable.id
}