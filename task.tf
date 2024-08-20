data "aws_iam_role" "ecs_task_execution_role" { name = "ecsTaskExecutionRole" }
resource "aws_ecs_task_definition" "app-runner" {
 container_definitions = jsonencode([{
  environment: [
   { name = "NODE_ENV", value = "production" }
  ],
  essential = true,
  image = "{aws_ecr_repository.my_repo.repository_url}:latest",
  name = local.container_name,
  portMappings = [{ containerPort = 8080 }],
 }])
 cpu = 512
 execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
 family = "family-of-${local.example}-tasks"
 memory = 1024
 network_mode = "awsvpc"
 requires_compatibilities = ["FARGATE"]
}
