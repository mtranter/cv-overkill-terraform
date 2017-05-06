output "security_group_id" {
  value = "${aws_security_group.alb.id}"
}

output "load_balancer_id" {
  value = "${aws_alb.alb.id}"
}

output "dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "load_balancer_arn" {
  value = "${aws_alb.alb.arn}"
}

output "listener_http_arn" {
  value = "${aws_alb_listener.http.arn}"
}
