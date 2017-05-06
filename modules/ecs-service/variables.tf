variable "alb_listener_rule_priority" {}
variable "alb_condition_field" {}
variable "alb_condition_values" {}
variable "service_name" {}
variable "alb_container_name" {}

variable "health_check_path" {
  default = "/"
}

variable "health_check_http_success_codes" {
  default = "200"
}

variable "service_port" {}

variable "task_definition" {}

variable "desired_count" {}

variable "deployment_maximum_percent" {
  default = "200"
}

variable "deployment_minimum_healthy_percent" {
  default = "50"
}
