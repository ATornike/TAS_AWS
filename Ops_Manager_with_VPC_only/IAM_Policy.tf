variable "iam_instance_profile_name" {
  type = string
  default = "VM-role-ops-manager-role-12345"
}

locals {
  s3_buckets = [for S3 in aws_s3_bucket.tas_s3_buckets : split(",", "${S3.arn}*,${S3.arn}/*")]
}

resource "aws_iam_policy" "policy" {
  name        = "TF_Policy_for_Ops_Man_and_Bosh"
  description = "IAM Policy for Ops_Manager VM and Bosh Director VM"


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Action = [
          "iam:Add*",
          "iam:Attach*",
          "iam:ChangePassword",
          "iam:Create*",
          "iam:DeactivateMFADevice",
          "iam:Delete*",
          "iam:Detach*",
          "iam:EnableMFADevice",
          "iam:GenerateCredentialReport",
          "iam:GenerateServiceLastAccessedDetails",
          "iam:GetAccessKeyLastUsed",
          "iam:GetAccountAuthorizationDetails",
          "iam:GetAccountPasswordPolicy",
          "iam:GetAccountSummary",
          "iam:GetContextKeysForCustomPolicy",
          "iam:GetContextKeysForPrincipalPolicy",
          "iam:GetCredentialReport",
          "iam:GetGroup",
          "iam:GetGroupPolicy",
          "iam:GetLoginProfile",
          "iam:GetOpenIDConnectProvider",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:GetSAMLProvider",
          "iam:GetSSHPublicKey",
          "iam:GetServerCertificate",
          "iam:GetServiceLastAccessedDetails",
          "iam:GetUser",
          "iam:GetUserPolicy",
          "iam:List*",
          "iam:Put*",
          "iam:RemoveClientIDFromOpenIDConnectProvider",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:RemoveUserFromGroup",
          "iam:ResyncMFADevice",
          "iam:SetDefaultPolicyVersion",
          "iam:SimulateCustomPolicy",
          "iam:SimulatePrincipalPolicy",
          "iam:Update*"
        ]
        Resource = "*"
      },
      {
        Sid    = "OpsMgrInfrastructureIaasConfiguration"
        Effect = "Allow"
        Action = [
          "ec2:DescribeKeypairs",
          "ec2:DescribeVpcs",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeAccountAttributes"
        ]
        Resource = "*"
      },
      {
        Sid    = "OpsMgrInfrastructureAvailabilityZones"
        Effect = "Allow"
        Action = [
          "ec2:DescribeAvailabilityZones"
        ]
        Resource = "*"
      },
      {
        Sid    = "OpsMgrInfrastructureNetworks"
        Effect = "Allow"
        Action = [
          "ec2:DescribeSubnets"
        ]
        Resource = "*"
      },
      {
        Sid    = "DeployMicroBosh"
        Effect = "Allow"
        Action = [
          "ec2:DescribeImages",
          "ec2:RunInstances",
          "ec2:DescribeInstances",
          "ec2:TerminateInstances",
          "ec2:RebootInstances",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
          "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
          "ec2:DescribeAddresses",
          "ec2:DisassociateAddress",
          "ec2:AssociateAddress",
          "ec2:CreateTags",
          "ec2:DescribeVolumes",
          "ec2:CreateVolume",
          "ec2:AttachVolume",
          "ec2:DeleteVolume",
          "ec2:DetachVolume",
          "ec2:CreateSnapshot",
          "ec2:DeleteSnapshot",
          "ec2:DescribeSnapshots",
          "ec2:DescribeRegions"
        ]
        Resource = "*"
      },
      {
        Sid    = "OpsMgrInfrastructureDirectorConfiguration"
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = flatten(local.s3_buckets)
      },
      {
        Sid    = "AllowToGetInfoAboutCurrentInstanceProfile"
        Effect = "Allow"
        Action = [
          "iam:GetInstanceProfile"
        ]
        Resource = [
          "${aws_iam_instance_profile.ins-profile.arn}"
        ]
      },
      {
        Sid    = "AllowToCreateInstanceWithCurrentInstanceProfile"
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = [
          "${aws_iam_role.ops-manager-iam-role.arn}"
        ]
      },
    ]
  })
}


resource "aws_iam_role" "ops-manager-iam-role" {
  name = var.iam_instance_profile_name

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com"
          ]
        },
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
    }
  )
}


resource "aws_iam_instance_profile" "ins-profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.ops-manager-iam-role.name
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ops-manager-iam-role.name
  policy_arn = aws_iam_policy.policy.arn
}
