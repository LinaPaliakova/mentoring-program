variable "aws_region" {
  default = "us-east-1"
}



variable "ecs_task_definition_name" {
  default = "my_task"
}

variable "ecs_container_name" {
   default = "my_container"
}

variable "ecs_cluster_name" {
  default = "my_cluster"
}

variable "ecs_service_name" {
  default = "my_ecs_service"
}
