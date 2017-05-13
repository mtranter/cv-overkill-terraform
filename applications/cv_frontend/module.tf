module "cv_frontend" {
  source = "./../../modules/s3-website"
  region = "${var.region}"
  website_domain = "marktranter.com"
}

resource "aws_cognito_identity_pool" "cv_app_pool" {
  identity_pool_name               = "cv_overkill_app_pool"
  allow_unauthenticated_identities = true

  supported_login_providers {
    "graph.facebook.com"  = "${var.facebook_appid}"
    "accounts.google.com" = "${var.google_clientid}"
  }
}

resource "aws_iam_role" "unauth_role" {
  name                = "cv_overkill_unauth_role"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.cv_app_pool.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role" "auth_role" {
  name                = "cv_overkill_auth_role"
  assume_role_policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.cv_app_pool.id}"
          },
          "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
          }
        }
      }
    ]
  }
EOF
}
