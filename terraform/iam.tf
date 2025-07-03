resource "aws_iam_role" "example" {
  name               = "terraform-lambda-example"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "example" {
  name   = "terraform-lambda-example"
  policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  # At the very least we always want our Lambda to be able to write it's logs to
  # CloudWatch. If this Lambda were to use other services we would add more
  # statements.
  statement {
    sid = "Logs"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "example" {
  role       = aws_iam_role.example.id
  policy_arn = aws_iam_policy.example.arn
}
