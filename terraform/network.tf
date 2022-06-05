# Se crea el VCP
resource "aws_vpc" "boutique_vpc" {
  cidr_block = "${var.cidr_block}.0.0/16"
}

# Se crea el Internet Gateway dentro del VPC
resource "aws_internet_gateway" "boutique_igw" {
 vpc_id =  aws_vpc.boutique_vpc.id
 tags = {
    Name = "boutique_igw"
  }
}

# Se crea los la RT
resource "aws_default_route_table" "boutique-rt" {
  default_route_table_id = aws_vpc.boutique_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boutique_igw.id
  }
  tags = {
    Name = "boutique-rt"
  }
}

# Subnet privada para todas los microservicios
resource "aws_subnet" "boutique_app_private-subnet" {
  vpc_id                  = aws_vpc.boutique_vpc.id
  cidr_block              = var.private_subnet_app
  availability_zone       = var.vpc_aws_az_a
  # Se bloquea ip publica ya que solo va a estar el balanceador
  map_public_ip_on_launch = "false"
  tags = {
    Name = "terraform-boutique_app-private-subnet"
  }
}

# Subnet privada para todas las BDs
resource "aws_subnet" "boutique_bd_private-subnet" {
  vpc_id                  = aws_vpc.boutique_vpc.id
  cidr_block              = var.private_subnet_bd
  availability_zone       = var.vpc_aws_az_b
  # Se bloquea ip publica ya que solo va a estar el balanceador
  map_public_ip_on_launch = "false"
  tags = {
    Name = "terraform-boutique_bd-private-subnet"
  }
}