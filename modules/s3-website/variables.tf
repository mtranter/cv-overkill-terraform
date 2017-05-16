variable "region" {}

variable "duplicate-content-penalty-secret" {
  default = "no-bots-please"
}

variable "website_subdomain"{
  default = "www"
}

variable "index_document" {
  default = "index.html"
}

variable "error_document" {
  default = "error.html"
}

variable "s3_bucket_acl" {
  default = "public-read"
}

variable "website_domain" {}

variable "routing_rules" {
  default = ""
}
