output "vpc_id" {
  value = "${aws_vpc.ecs_alb.id}"
}

output "vpc_route_table_id" {
  value = "${aws_vpc.ecs_alb.main_route_table_id}"
}

output "subnet_ids" {
  value = ["${aws_subnet.ecs_alb.*.id}"]
}
