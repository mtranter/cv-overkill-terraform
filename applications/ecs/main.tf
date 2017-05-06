module "vpc" {
  source = "./../../modules/vpc"
  vpc_cidr_block = "10.10.0.0/16"
}

module "alb" {
  source          = "./../../modules/alb"
  alb_name        = "ecs-alb"
  subnet_ids      = ["${module.vpc.subnet_ids}"]
  vpc_id          = "${module.vpc.vpc_id}"
  internal        = false
  http_allowed_cidr_blocks = ["0.0.0.0/0"]
}

module "ecs" {
  source                    = "./../../modules/ecs-cluster"
  key_name                  = "${var.ecs_instance_key_name}"
  subnet_ids                = ["${module.vpc.subnet_ids}"]
  vpc_id                    = "${module.vpc.vpc_id}"
  alb_security_group_id     = "${module.alb.security_group_id}"
  ssh_allowed_cidr_blocks   = ["80.7.136.0/24"]
  ecs_cluster_name          = "cv-ecs-cluster"
}
