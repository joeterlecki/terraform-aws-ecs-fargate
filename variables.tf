variable "environment" {
  type        = string
  default     = null
  description = "The defining environment of the Account: DEV, TST, STG, PRD, ROOT"
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The vpc to place the security group"
}

variable "log_group_prefix" {
  type        = string
  default     = "/ecs/"
  description = "The path / prefix for the task log group"
}

variable "ecs_cluster_name" {
  type        = string
  default     = null
  description = "Desired ecs cluster name"
}

variable "cluster_capacity_providers" {
  type        = list(string)
  default     = ["FARGATE"]
  description = "List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT"
}

variable "ecs_task_definition_family_name" {
  type        = string
  default     = null
  description = "A unique name for your task definition"
}

variable "ecs_task_role_arn" {
  type        = string
  default     = null
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services"
}

variable "ecs_execution_role_arn" {
  type        = string
  default     = null
  description = "The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
}

variable "ecs_task_cpu" {
  type        = string
  default     = "512"
  description = "The desired cpu resources for the container"
}

variable "ecs_task_memory" {
  type        = string
  default     = "1024"
  description = "The desired memory resrouce for the container"
}

variable "ecs_task_container_definition" {
  type    = list(any)
  default = []
}

variable "ecs_service_name" {
  type        = string
  default     = null
  description = "The desired name for the ecs service"
}

variable "ecs_service_desried_count" {
  type        = number
  default     = 1
  description = "The desired number of tasks to be created per task definition"
}

variable "ecs_service_iam_role" {
  type        = string
  default     = null
  description = "ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf See Official Docs."
}

variable "ecs_service_depends_on" {
  type        = string
  default     = null
  description = "The IAM role above to ensure the IAM policy doesnt get destroyed before the service."
}

variable "ecs_service_weight" {
  type        = number
  default     = 1
  description = "The relative percentage of the total number of launched tasks that should use the specified capacity provider"
}

variable "ecs_service_base" {
  type        = number
  default     = 0
  description = "The number of tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a base defined"
}

variable "ecs_service_security_groups" {
  type        = list(string)
  default     = null
  description = "List of security groups to be attched to the ecs service"
}

variable "ecs_service_subnets" {
  type        = list(string)
  default     = null
  description = "List of subnet ids to be attached to the ecs service"
}

variable "tags" {
  type    = map(string)
  default = {}
}

locals {
  tags = merge(
    var.tags,
    {
      Environment  = var.environment
      Provisioning = "terraform"
    },
  )
}