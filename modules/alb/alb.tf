resource "aws_alb" "alb" {
  name            = "${var.alb_name}"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${var.subnet_ids}"]
  internal        = "${var.internal}"
}

resource "aws_alb_target_group" "target_group_default" {
  name     = "${var.alb_name}-default"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group_default.arn}"
    type             = "forward"
  }
}
