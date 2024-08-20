terraform {
 required_version = "~> 1.3"

 required_providers {
  aws = {
   source  = "hashicorp/aws"
   version = ">= 5.37"
  }
 
 }
}

locals {
 container_name = "hello-world-container"
 example = "hello-world-ecs-example"
}


