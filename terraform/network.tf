resource "aws_vpc" "boutique_vpc" {
  cidr_block = "${var.cidr_block}.0.0/16"
}

resource "aws_internet_gateway" "boutique_igw" {
 vpc_id =  aws_vpc.boutique_vpc.id
 tags = {
    Name = "boutique_igw"
  }
}

