data "aws_ami" "ecs-optimized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "template_file" "ecs_config" {
  template = "${file("${path.module}/ecs.config")}"

  vars {
    ecs_cluster_name    = "${aws_ecs_cluster.ecs_cluster.name}"
  }
}
