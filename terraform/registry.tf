resource "aws_ecr_repository" "boutique_registry" {
  name                 = "boutique"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}