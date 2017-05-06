resource "aws_security_group" "alb" {
  name        = "alb_${var.alb_name}"
  description = "ALB security group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "alb_${var.alb_name}"
  }
}

# Create security group rules to add to the security groups
# https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "load_balancer_http" {
  # Allow HTTP traffic
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = "${var.http_allowed_cidr_blocks}"
  security_group_id = "${aws_security_group.alb.id}"
}


resource "aws_security_group_rule" "load_balancer_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb.id}"
}
