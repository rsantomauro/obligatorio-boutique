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

# Se asigna la zona de disponibilidad a
variable "vpc_aws_az_a" {
  default = "us-east-1a"
}

# Se asigna la zona de disponibilidad b
variable "vpc_aws_az_b" {
  default = "us-east-1b"
}

variable "repository_list" {
  description = "List of repository names"
  type = list
  default = ["adservice", "checkoutservice", "currencyservice", "emailservice", "frontend", "loadgenerator", "paymentservice", "productcatalogservice", "recommendationservice", "shippingservice"]
}

variable "all_microservices" {
  description = "List of repository names"
  type = list
  default = ["adservice", "cartservice", "checkoutservice", "currencyservice", "emailservice", "frontend", "loadgenerator", "paymentservice", "productcatalogservice", "recommendationservice", "shippingservice", "redis"]
}