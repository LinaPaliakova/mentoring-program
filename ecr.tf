module "ecr" {
 source  = "terraform-aws-modules/ecr/aws"
 version = "2.2.1"


 repository_force_delete = true
 repository_name = local.example
 repository_lifecycle_policy = jsonencode({
  rules = [{
   action = { type = "expire" }
   description = "Delete all images except a handful of the newest images"
   rulePriority = 1
   selection = {
    countNumber = 3
    countType = "imageCountMoreThan"
    tagStatus = "any"
   }
  }]
 })
}

resource "docker_image" "this" {
 name = format("%v:%v", module.ecr.repository_url, formatdate("YYYY-MM-DD'T'hh-mm-ss", timestamp()))

 build { context = "." } # Path to our local Dockerfile
}

# * Push our container image to our ECR.
resource "docker_registry_image" "this" {
 keep_remotely = true # Do not delete old images when a new image is pushed
 name = resource.docker_image.this.name
}
