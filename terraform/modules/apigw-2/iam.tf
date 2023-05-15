
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ApigwSfnRole" {
  name               = "ApiGwSfnRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["logs:*","states:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "ApiGwSfnPolicy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "ApiGwSfnPolicyAttachment"
  roles      = [aws_iam_role.ApigwSfnRole.name]
  policy_arn = aws_iam_policy.policy.arn
}
