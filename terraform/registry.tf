# Se crea el repositorio donde se almacenaran las imagenes de los microservicios Boutique
resource "aws_ecr_repository" "boutique_ecr" {
  name                 = "boutique_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

## Build docker images and push to ECR
resource "docker_registry_image" "boutique" {
    for_each = toset(var.repository_list)
    name = "${aws_ecr_repository.boutique_ecr.repository_url}:${each.key}"

    build {
        context = "../src/${each.key}"
        dockerfile = "Dockerfile"
    }  
}

# ajuste para cartservice que tiene el dockerfile en otro lado
resource "docker_registry_image" "boutique_forcartservice" {
    name = "${aws_ecr_repository.boutique_ecr.repository_url}:cartservice"

    build {
        context = "../src/cartservice/src"
        dockerfile = "Dockerfile"
    }  
}