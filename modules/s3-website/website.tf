provider "aws" {
  region = "${var.region}"
}



resource "aws_s3_bucket" "web_app" {
  bucket = "${var.website_subdomain}.${var.website_domain}"
  acl    = "${var.s3_bucket_acl}"
  policy = "${data.template_file.bucket_policy.rendered}"

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }
}

data "template_file" "bucket_policy" {
  template = "${file("${path.module}/website-bucket-policy.json")}"

  vars {
    bucket = "${var.website_subdomain}.${var.website_domain}"
    secret = "${var.duplicate-content-penalty-secret}"
  }
}

data "aws_route53_zone" "selected" {
  name         = "${var.website_domain}."
  private_zone = false
}

resource "aws_route53_record" "domain" {
   name = "${var.website_subdomain}.${var.website_domain}"
   zone_id = "${data.aws_route53_zone.selected.zone_id}"
   type = "A"
   alias {
     name = "${aws_s3_bucket.web_app.website_domain}"
     zone_id = "${aws_s3_bucket.web_app.hosted_zone_id}"
     evaluate_target_health = true
   }
}
