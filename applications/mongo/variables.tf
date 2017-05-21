variable "vpc_id" {}
variable "ecs_cluster_id" {}
variable "ecs_service_role_arn" {}
variable "ecs_subnet_ids" {
  type = "list"
}
variable "ecs_security_group_id" {}
variable "vpc_cidr_block" {}
variable "internal_zone_id" {}
