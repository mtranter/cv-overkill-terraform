module "cv_frontend" {
  source = "./../../modules/s3-website"
  region = "${var.region}"
  website_domain = "marktranter.com"

}

resource "aws_iam_openid_connect_provider" "auth_zero" {
    url             = "https://marktranter.eu.auth0.com"
    client_id_list  = [
     "${var.auth_zero_clientid}"
    ]
    thumbprint_list = ["${var.auth_zero_thumbprint}"]
}

resource "aws_cognito_identity_pool" "cv_app_pool" {
  identity_pool_name               = "cv_overkill_app_pool"
  allow_unauthenticated_identities = true
  openid_connect_provider_arns = ["${aws_iam_openid_connect_provider.auth_zero.arn}"]
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

resource "aws_iam_role" "admin_role" {
  name                = "cv_overkill_admin_role"
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
            "cognito-identity.amazonaws.com:amr": [
              "*github|3257273",
              "*linkedin|uuiwPHDOf3"
            ]
          }
        }
      }
    ]
  }
EOF
}
