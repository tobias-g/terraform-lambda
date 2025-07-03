data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/function/src" # where our NodeJS code is
  output_path = "${path.module}/source.zip"   # don't forget to add this to .gitignore
}

data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "example" {
  filename         = data.archive_file.source.output_path
  function_name    = local.lambda_name
  role             = aws_iam_role.example.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.source.output_base64sha256
  runtime          = "nodejs20.x"
  depends_on       = [aws_cloudwatch_log_group.logs]
}
