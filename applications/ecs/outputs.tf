output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "ecs_cluster_id" {
  value = "${module.ecs.ecs_cluster_id}"
}

output "ecs_service_role_arn" {
  value = "${module.ecs.ecs_service_role_arn}"
}

output "security_group_id" {
  value = "${module.alb.security_group_id}"
}

output "load_balancer_id" {
  value = "${module.alb.load_balancer_id}"
}

output "load_balancer_arn" {
  value = "${module.alb.load_balancer_arn}"
}

output "listener_http_arn" {
  value = "${module.alb.listener_http_arn}"
}
