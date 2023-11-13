data "aws_iam_policy_document" "developer" {
  statement {
    sid    = "AllowDeveloper"
    effect = "Allow"
    actions = [
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:AccessKubernetesApi",
      "ssm:GetParameter",
      "eks:ListUpdates",
      "eks:ListFargateProfiles"
    ]
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "admin" {
  statement {
    sid       = "AllowAdmin"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iamPassedToService"
      values   = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "manager_assume_role" {
  statement {
    sid    = "AllowManagerAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"
      # When you are adding a group to a the the principle you use an account instead of the arn
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/manager"] #( this is for a user)
      #identifiers = [data.aws_caller_identity.current.account_id]
      #identifiers = ["data.aws_caller_identity.current.account_id]
    }
  }
}
data "aws_caller_identity" "current" {}