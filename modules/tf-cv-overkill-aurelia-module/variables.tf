variable "region" {}

variable "module_name" {}

variable "relative_source_path" {}

variable "website_files" {
  type = "list"
}

variable "content_type_map" {
  default = {
    "html"    = "text/html",
    "js"      = "application/javascript",
    "css"     = "text/css",
    "jpg"     = "image/jpeg",
    "jpeg"    = "image/jpeg",
    "gif"     = "image/gif",
    "png"     = "image/png",
    "svg"     = "image/svg+xml"
  }
}
