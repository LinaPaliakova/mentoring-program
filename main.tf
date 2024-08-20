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


resource "aws_ecs_service" "this" {
 cluster = module.ecs.cluster_id
 desired_count = 1
 launch_type = "FARGATE"
 name = "${local.example}-service"
 task_definition = resource.aws_ecs_task_definition.this.arn

 lifecycle {
  ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly around auto-scaling.
 }
}
