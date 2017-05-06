data "terraform_remote_state" "ecs_cluster" {
 backend = "s3"

 config {
   bucket  = "cv-overkill-tf-state"
   key     = "aws-infrastructure"
   region  = "eu-west-1"
 }
}
