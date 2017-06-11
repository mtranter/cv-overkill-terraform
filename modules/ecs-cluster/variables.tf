variable "ecs_cluster_name" {}

# The instance type to use when creating the cluster instances
variable "instance_type" {
  default = "t2.small"
}

# The name of the keypair to attach to the instances.
variable "key_name" {}

# The VPC to create the cluster in
variable "vpc_id" {}

# A list of subnets to add the cluster instances to
variable "subnet_ids" {
  type = "list"
}

# The minimum number of nodes to run in the ecs cluster
variable "min_size" {
  default = 1
}

# The maximum number of nodes to allow the ecs cluster to grow to
variable "max_size" {
  default = 2
}

# The number of nodes to run normally
variable "desired_size" {
  default = 2
}

# The security group id of the external load balancer
variable "alb_security_group_id" {
  default = ""
}

# The ip address blocks to allow ssh access
variable "ssh_allowed_cidr_blocks" {
  type = "list"
}

variable "vpc_cidr_block" {}
