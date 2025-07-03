# We create the log group in Terraform instead of letting the Lambda function
# create it so we can manage the retention period. For this to work we also need
# to make sure the aws_lambda_function depends on this resource.
resource "aws_cloudwatch_log_group" "logs" {
  name              = "/aws/lambda/${local.lambda_name}"
  retention_in_days = 7
}
