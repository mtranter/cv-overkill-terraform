resource "aws_security_group" "ecs" {
  name        = "ecs_sg"
  description = "ECS Security Group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "ecs_sg"
  }
}

resource "aws_security_group_rule" "ecs_tcp_external" {
  type                     = "ingress"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = "${var.alb_security_group_id}"
  security_group_id        = "${aws_security_group.ecs.id}"
}

resource "aws_security_group_rule" "vpc_inbound" {
  type                     = "ingress"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
  security_group_id        = "${aws_security_group.ecs.id}"
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["${compact(var.ssh_allowed_cidr_blocks)}"]
  security_group_id = "${aws_security_group.ecs.id}"
}

resource "aws_security_group_rule" "out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs.id}"
}
