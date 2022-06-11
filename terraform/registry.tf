# Se crea el repositorio donde se almacenaran las imagenes de los microservicios Boutique
resource "aws_ecr_repository" "boutique_ecr" {
  name                 = "boutique_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name       = "boutique_ecr"
  }
}