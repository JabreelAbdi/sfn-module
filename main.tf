#####################
#First state machine
#####################

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "First-state-machine"
  role_arn = aws_iam_role.step-function-role.arn

  definition = jsonencode(local.throttle-definition)

}


resource "aws_iam_role" "step-function-role" {
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
  name               = "step-function-role"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "step-function-policy-document" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:*",
      "xray:*",
      "mgn:*",
      "dynamodb:BatchWriteItem",
      "s3:HeadObject",
      "s3:GetObject",
      "logs:UpdateLogDelivery",
      "logs:PutResourcePolicy",
      "logs:ListLogDeliveries",
      "logs:GetLogDelivery",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups",
      "logs:DeleteLogDelivery",
      "logs:CreateLogDelivery"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "step-function-policy" {
  name   = "step-function-policy"
  policy = data.aws_iam_policy_document.step-function-policy-document.json
}

resource "aws_iam_role_policy_attachment" "step-function-policy-attachment" {
  role       = aws_iam_role.step-function-role.name
  policy_arn = aws_iam_policy.step-function-policy.arn
}


#####################
#Second state machine
#####################

resource "aws_sfn_state_machine" "sfn_state_machine_2" {
  name     = "Second-state-machine"
  role_arn = aws_iam_role.step-function-role.arn

  definition = jsonencode(local.throttle-definition-2)

}


resource "aws_iam_role" "step-function-role_2" {
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy_2.json
  name               = "second-function-role"
}

data "aws_iam_policy_document" "instance-assume-role-policy_2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "step-function-policy-document_2" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:*",
      "xray:*",
      "mgn:*",
      "dynamodb:BatchWriteItem",
      "s3:HeadObject",
      "s3:GetObject",
      "logs:UpdateLogDelivery",
      "logs:PutResourcePolicy",
      "logs:ListLogDeliveries",
      "logs:GetLogDelivery",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups",
      "logs:DeleteLogDelivery",
      "logs:CreateLogDelivery"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "step-function-policy_2" {
  name   = "second-step-function-policy"
  policy = data.aws_iam_policy_document.step-function-policy-document_2.json
}

resource "aws_iam_role_policy_attachment" "step-function-policy-attachment_2" {
  role       = aws_iam_role.step-function-role_2.name
  policy_arn = aws_iam_policy.step-function-policy_2.arn
}
