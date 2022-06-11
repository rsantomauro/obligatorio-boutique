# Se crea el VCP
resource "aws_vpc" "boutique_vpc" {
  cidr_block = "${var.cidr_block}0.0/16"
  tags = {
    Name = "boutique_vpc"
  }
}

# Se crea el Internet Gateway dentro del VPC
resource "aws_internet_gateway" "boutique_igw" {
 vpc_id =  aws_vpc.boutique_vpc.id
 tags = {
    Name = "boutique_igw"
  }
}

# Se crea los la RT
resource "aws_default_route_table" "boutique_rt" {
  default_route_table_id = aws_vpc.boutique_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boutique_igw.id
  }
  tags = {
    Name = "boutique_rt"
  }
}

# Subnet privada para todas los zonas a
resource "aws_subnet" "boutique_az_a_private-subnet" {
  vpc_id                  = aws_vpc.boutique_vpc.id
  cidr_block              = var.private_subnet_a
  availability_zone       = var.vpc_aws_az_a
  # Se bloquea ip publica ya que solo va a estar el balanceador
  map_public_ip_on_launch = "false"
  tags = {
    Name = "terraform-boutique_az_a_private-subnet"
  }
}

# Subnet privada para todas las zonas b
resource "aws_subnet" "boutique_az_b_private-subnet" {
  vpc_id                  = aws_vpc.boutique_vpc.id
  cidr_block              = var.private_subnet_b
  availability_zone       = var.vpc_aws_az_b
  # Se bloquea ip publica ya que solo va a estar el balanceador
  map_public_ip_on_launch = "false"
  tags = {
    Name = "terraform-boutique_az_b_private-subnet"
  }
}

resource "aws_subnet" "p6-public-subnet" {
  vpc_id                  = aws_vpc.boutique_vpc.id
  cidr_block              = var.public_subnet
  availability_zone       = var.vpc_aws_az_a
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terraform-boutique-public-subnet"
  }
}