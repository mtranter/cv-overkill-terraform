data "aws_availability_zones" "available"{}


resource "aws_elb" "internal_elb" {
  name               = "cv-overkill-elb-internal"
  internal                    = true
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  subnets                     = ["${var.ecs_subnet_ids}"]
  security_groups             = ["${var.ecs_security_group_id}"]

  listener {
    instance_port = 27017
    instance_protocol = "tcp"
    lb_port = 27017
    lb_protocol = "tcp"
  }

}

resource "aws_route53_record" "mongo_dns" {
  zone_id = "${var.internal_zone_id}"
  name    = "mongo"
  type = "A"
  alias {
    name = "${aws_elb.internal_elb.dns_name}"
    zone_id = "${aws_elb.internal_elb.zone_id}"
    evaluate_target_health = false
  }
}


resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.mongo.arn}"
  desired_count   = 1
  iam_role        = "${var.ecs_service_role_arn}"

  load_balancer {
    elb_name       = "${aws_elb.internal_elb.name}"
    container_name = "mongo"
    container_port = 27017
  }

}

resource "aws_ecs_task_definition" "mongo" {
  family = "mongo"
  container_definitions = <<EOF
[
  {
    "name": "mongo",
    "image": "mongo",
    "cpu": 256,
    "memory": 512,
    "portMappings": [{"containerPort": 27017, "hostPort": 27017}]
  }
]
EOF
}
