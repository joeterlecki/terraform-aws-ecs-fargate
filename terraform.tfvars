environment                     = "Root"
ecs_cluster_name                = "test-cluster"
ecs_task_definition_family_name = "test-task-def" //Make sure to replicate name to awslogs-group
ecs_execution_role_arn          = "execution-role"
ecs_task_role_arn               = "arn:aws:iam::134905014910:role/root/gitlab-runner-ecs-task-execution-role"
ecs_task_container_definition = [
  {
    image = "ecr-image-url"
    name  = "container-name"
    logConfiguration = {
      logdriver = "awslogs"
      options = {
        "awslogs-group"         = "/ecs/task-name"
        "awslogs-region"        = "us-east-1"
        "awslogs-stream-prefix" = "ecs"
      }
    }
    portMappings = [
      {
        hostPort      = 80
        protocol      = "tcp"
        containerPort = 80
      },
      {
        hostPort      = 443
        protocol      = "tcp"
        containerPort = 443
    }]
    command = ["/start.sh"]
    environment = [{
      name  = "value"
      value = "value"
    }]
    workingDirectory  = "/home/"
    memoryReservation = 700
    essential         = true
  }
]

ecs_service_name            = "test-service"
ecs_service_security_groups = []
ecs_service_subnets         = []
