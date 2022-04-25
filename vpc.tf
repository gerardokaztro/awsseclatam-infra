provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
    CIDRMayor = "10.0.0.0/8"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_az"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public_subnet_az"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet_az"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public_subnet_az"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_subnet" "subnet5" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "database_subnet_az"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_subnet" "subnet6" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name = "database_subnet_az"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id

  

  tags = {
    Name = "private_rt"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_route_table_association" "a_private_sbnt1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "a_private_sbnt3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table" "rt_db" {
  vpc_id = aws_vpc.main.id

  

  tags = {
    Name = "database_rt"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_route_table_association" "a_db_sbnt5" {
  subnet_id      = aws_subnet.subnet5.id
  route_table_id = aws_route_table.rt_db.id
}

resource "aws_route_table_association" "a_db_sbnt6" {
  subnet_id      = aws_subnet.subnet6.id
  route_table_id = aws_route_table.rt_db.id
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}

resource "aws_route_table_association" "a_public_sbnt2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "a_public_sbnt4" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
    VPC = "10.0.0.0/16"
    Provisioned = "Terraform"
    OwnerTeam = "Cybersecurity"
  }
}