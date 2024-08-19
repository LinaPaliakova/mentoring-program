data "aws_iam_role" "ecs_task_execution_role" { name = "ecsTaskExecutionRole" }
resource "aws_ecs_task_definition" "my_task_definition" {
  family = "my-task-definition"
  container_definitions = jsonencode([
    {
      name = "my-container"
      image = "${aws_ecr_repository.my_repository.repository_url}:latest"
      network_mode            = "bridge"
      memory                  = 512
      memory_reservation      = 256
      
    }
  ])
}
