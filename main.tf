resource "aws_security_group" "ecs_security_group" {
  name        = "${var.ecs_cluster_name}-security-group"
  description = "Security group for ${var.ecs_cluster_name} related traffic"
  vpc_id      = "vpc-016000a7abbe29c70"
  tags        = merge({ Name = "${var.ecs_cluster_name}-security-group" }, local.tags)
}

resource "aws_security_group_rule" "ecs_outbound_rule_vpc_cidr" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs_security_group.id
  cidr_blocks       = ["10.0.0.0/20"]
}

resource "aws_security_group_rule" "ecs_outbound_rule_nat" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_security_group.id
  source_security_group_id = "sg-08ae0199ec957a564"
}

resource "aws_security_group_rule" "ecs_outbound_rule_endpoint_prefix" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs_security_group.id
  prefix_list_ids   = ["pl-63a5400a", "pl-02cd2c6b"]
}

resource "aws_cloudwatch_log_group" "ecs_task_log_group" {
  name = "${var.log_group_prefix}${var.ecs_task_definition_family_name}"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name               = var.ecs_cluster_name
  capacity_providers = var.cluster_capacity_providers
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = merge(local.tags)
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  container_definitions    = jsonencode(var.ecs_task_container_definition)
  family                   = var.ecs_task_definition_family_name
  task_role_arn            = var.ecs_task_role_arn
  execution_role_arn       = var.ecs_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  tags                     = merge(local.tags)
}

resource "aws_ecs_service" "ecs_service" {
  name                    = var.ecs_service_name
  cluster                 = aws_ecs_cluster.ecs_cluster.id
  desired_count           = var.ecs_service_desried_count
  task_definition         = aws_ecs_task_definition.ecs_task_definition.family
  iam_role                = var.ecs_service_iam_role
  depends_on              = [var.ecs_service_depends_on]
  enable_ecs_managed_tags = true
  platform_version        = "LATEST"
  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = var.ecs_service_weight
    base              = var.ecs_service_base
  }

  network_configuration {
    security_groups = var.ecs_service_security_groups
    subnets         = var.ecs_service_subnets
  }
}
