resource "aws_ecs_service" "service" {
  name                               = "${var.service_name}"
  cluster                            = "${data.terraform_remote_state.ecs_cluster.ecs_cluster_id}"
  task_definition                    = "${aws_ecs_task_definition.task.arn}"
  desired_count                      = "${var.desired_count}"
  iam_role                           = "${data.terraform_remote_state.ecs_cluster.ecs_service_role_arn}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.target_group_service.arn}"
    container_name   = "${var.alb_container_name}"
    container_port   = "${var.service_port}"
  }
}

resource "aws_ecs_task_definition" "task" {
  family = "${var.service_name}"

  container_definitions = "${var.task_definition}"
}
