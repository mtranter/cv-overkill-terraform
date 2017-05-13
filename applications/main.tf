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

module "frontend_website" {
  source          = "./cv_frontend"
  region          = "${var.region}"
  google_clientid = "${var.google_clientid}"
  facebook_appid  = "${var.facebook_appid}"
}

module "ecs_cluster" {
  source = "./ecs"
  ecs_instance_key_name = "${aws_key_pair.root.key_name}"
}
