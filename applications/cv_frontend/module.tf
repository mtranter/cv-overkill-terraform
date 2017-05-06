module "cv_frontend" {
  source = "./../../modules/s3-website"
  region = "${var.region}"
  website_domain = "marktranter.com"
}
