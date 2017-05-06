resource "aws_alb_listener_rule" "http" {
  listener_arn = "${data.terraform_remote_state.ecs_cluster.listener_http_arn}"
  priority     = "${var.alb_listener_rule_priority}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.target_group_service.arn}"
  }

  condition {
    field  = "${var.alb_condition_field}"
    values = ["${var.alb_condition_values}"]
  }
}

resource "aws_alb_target_group" "target_group_service" {
  name     = "${var.alb_container_name}-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.ecs_cluster.vpc_id}"

  health_check {
    path    = "${var.health_check_path}"
    matcher = "${var.health_check_http_success_codes}"
  }
}
