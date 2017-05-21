terraform {
  backend "s3" {
    bucket  = "cv-overkill-tf-state"
    key     = "aws-infrastructure"
    region  = "eu-west-1"
  }
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "root" {
  key_name = "ecs_key"
  public_key = "${var.public_key}"
}

resource "aws_route53_zone" "internal" {
  name        = "marktranter.com."
  vpc_id      = "${module.ecs_cluster.vpc_id}"
}

module "frontend_website" {
  source                = "./cv_frontend"
  region                = "${var.region}"
  google_clientid       = "${var.google_clientid}"
  facebook_appid        = "${var.facebook_appid}"
  auth_zero_clientid    = "${var.auth_zero_clientid}"
  auth_zero_thumbprint  = "${var.auth_zero_thumbprint}"
}

module "ecs_cluster" {
  source = "./ecs"
  ecs_instance_key_name = "${aws_key_pair.root.key_name}"
}

module "mongo" {
  source = "./mongo"
  ecs_cluster_id          = "${module.ecs_cluster.ecs_cluster_id}"
  ecs_service_role_arn    = "${module.ecs_cluster.ecs_service_role_arn}"
  ecs_security_group_id   = "${module.ecs_cluster.ecs_security_group_id}"
  vpc_id                  = "${module.ecs_cluster.vpc_id}"
  ecs_subnet_ids          = "${module.ecs_cluster.subnet_ids}"
  vpc_cidr_block          = "${module.ecs_cluster.vpc_cidr_block}"
  internal_zone_id        = "${aws_route53_zone.internal.id}"
}
