# Self-hosted Retool on AWS

Self-hosted Retool deployment on AWS backed by ECS and RDS. Based on the [CloudFormation](https://github.com/tryretool/retool-onpremise/tree/master/cloudformation) from Retool and [on-premise documentation](https://docs.retool.com/docs/self-hosted).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.53.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.retool_database](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.retool_database](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/db_subnet_group) | resource |
| [aws_ecs_cluster.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.retool_api](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/ecs_service) | resource |
| [aws_ecs_service.retool_jobs_runner](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.retool_api](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.retool_jobs_runner](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.retool_execution](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/iam_role) | resource |
| [aws_iam_role.retool_task](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/iam_role) | resource |
| [aws_lb.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/lb) | resource |
| [aws_lb_listener.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/lb_target_group) | resource |
| [aws_secretsmanager_secret.retool_database_password](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.retool_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.retool_jwt_secret](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.retool_license_key](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.retool_database_password](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.retool_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.retool_jwt_secret](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.retool_license_key](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.ingress](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/security_group) | resource |
| [aws_security_group.retool](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/security_group) | resource |
| [aws_security_group.retool_database](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/resources/security_group) | resource |
| [random_password.retool_database_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.retool_encryption_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.retool_jwt_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/data-sources/caller_identity) | data source |
| [aws_subnets.subnets](https://registry.terraform.io/providers/hashicorp/aws/4.53.0/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_retool_license_key"></a> [retool\_license\_key](#input\_retool\_license\_key) | Retool license key. | `string` | `"EXPIRED-LICENSE-KEY-TRIAL"` | no |
| <a name="input_retool_version"></a> [retool\_version](#input\_retool\_version) | Retool version number. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the load balancer. |

