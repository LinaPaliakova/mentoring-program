data "aws_iam_role" "ecs_task_execution_role" { name = "ecsTaskExecutionRole" }
resource "aws_ecs_task_definition" "this" {
 container_definitions = jsonencode([{
  image = resource.docker_registry_image.this.name,
  name = local.container_name,
  portMappings = [{ containerPort = 8080 }],
 }])
 cpu = 256
 execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
 family = "family-of-${local.example}-tasks"
 memory = 512
 network_mode = "awsvpc"
 requires_compatibilities = ["FARGATE"]
}
