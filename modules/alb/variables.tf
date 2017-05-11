# The name of the ALB
variable "alb_name" {}

# A list of subnet ids to add the load balancer to.
variable "subnet_ids" {
  type = "list"
}

# The VPC to create the load balancer in.
variable "vpc_id" {}

# IP address ranges to allow access to the load balancer
variable "http_allowed_cidr_blocks" {
  type = "list"
}

# Whether the ALB should be internal or not
variable "internal" {
  default = true
}

variable "website_domain" {}
