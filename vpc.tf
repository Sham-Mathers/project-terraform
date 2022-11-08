resource "aws_vpc" "main" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "c35-terraform"
  }
}
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "c35-public-subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "c35-public-subnet-2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "c35-private-subnet-1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "c35-private-subnet-2"
  }
}

resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "c35-igw"
  }
}

resource "aws_eip" "project-eip" {
  vpc      = true
}

resource "aws_nat_gateway" "project-nat" {
  allocation_id = aws_eip.project-eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "c35-nat"
  }
}

resource "aws_route_table" "private_route_table" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.project-nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "associate_routetable_to_public_subnet_1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "associate_routetable_to_public_subnet_2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "associate_routetable_to_private_subnet_1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "associate_routetable_to_private_subnet_2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_route_table.id
}
