output "website_bucket_id" {
  value = "${module.frontend_website.website_bucket_id}"
}
output "ecs_cluster_id" {
  value = "${module.ecs_cluster.ecs_cluster_id}"
}

output "ecs_service_role_arn" {
  value = "${module.ecs_cluster.ecs_service_role_arn}"
}

output "security_group_id" {
  value = "${module.ecs_cluster.security_group_id}"
}

output "load_balancer_id" {
  value = "${module.ecs_cluster.load_balancer_id}"
}

output "dns_name" {
  value = "${module.ecs_cluster.dns_name}"
}

output "load_balancer_arn" {
  value = "${module.ecs_cluster.load_balancer_arn}"
}

output "listener_http_arn" {
  value = "${module.ecs_cluster.listener_http_arn}"
}

output "vpc_id" {
  value = "${module.ecs_cluster.vpc_id}"
}
