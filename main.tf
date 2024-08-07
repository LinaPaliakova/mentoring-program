terraform {
 required_version = "~> 1.3"

 required_providers {
  aws = {
   source  = "hashicorp/aws"
   version = ">= 5.37"
  }
  docker = {
   source  = "kreuzwerker/docker"
   version = "~> 3.0"
  }
 }
}

locals {
 container_name = "hello-world-container"
 example = "hello-world-ecs-example"
}


# * Give Docker permission to pusher Docker images to AWS
data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "this" {}
data "aws_region" "this" {}
locals { ecr_address = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.this.name) }
provider "docker" {
 registry_auth {
  address  = local.ecr_address
  password = data.aws_ecr_authorization_token.this.password
  username = data.aws_ecr_authorization_token.this.user_name
 }
}

resource "aws_ecs_service" "this" {
 cluster = module.ecs.cluster_id
 desired_count = 1
 launch_type = "FARGATE"
 name = "${local.example}-service"
 task_definition = resource.aws_ecs_task_definition.this.arn

 lifecycle {
  ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly around auto-scaling.
 }

network_configuration {
  security_groups = [module.vpc.default_security_group_id]
  subnets = module.vpc.private_subnets
 }

 
}
