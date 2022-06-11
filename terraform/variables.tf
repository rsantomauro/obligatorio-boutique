# Se define el perfil de AWS Cli
variable "perfil" {
    default = "default"
}

# Se define la region de AWS Cli
variable "region" {
  default = "us-east-1"
}

# Se define la porcion de red
variable "cidr_block" {
    default = "172.16."
}

# Se define la porcion de host mediante la porcion de red
variable "private_subnet_a" {
  default = "${var.cidr_block}1.0/24"
}

# Se define la porcion de host mediante la porcion de red
variable "private_subnet_b" {
  default = "${var.cidr_block}2.0/24"
}

# Se define la porcion de host mediante la porcion de red
variable "public_subnet" {
  default = "${var.cidr_block}3.0/24"
}

# Se asigna la zona de disponibilidad a
variable "vpc_aws_az-a" {
  default = "us-east-1a"
}

# Se asigna la zona de disponibilidad b
variable "vpc_aws_az-b" {
  default = "us-east-1b"
}