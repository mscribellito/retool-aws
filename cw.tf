resource "aws_cloudwatch_log_group" "retool" {
  name              = "retool"
  retention_in_days = 14
}