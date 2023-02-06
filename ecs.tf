resource "aws_ecs_cluster" "retool" {
  name = "retool"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

// task definintions

resource "aws_ecs_task_definition" "retool_api" {
  family = "retool-api"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  task_role_arn      = aws_iam_role.retool_task.arn
  execution_role_arn = aws_iam_role.retool_execution.arn

  container_definitions = jsonencode([
    {
      name      = "retool-api"
      image     = "${local.retool_image}"
      essential = true
      environment = [
        {
          name : "NODE_ENV",
          value : "production"
        },
        {
          name : "SERVICE_TYPE",
          value : "MAIN_BACKEND,DB_CONNECTOR,DB_SSH_CONNECTOR"
        },
        {
          name : "FORCE_DEPLOYMENT",
          value : "false"
        },
        {
          name : "POSTGRES_DB",
          value : "hammerhead_production"
        },
        {
          name : "POSTGRES_HOST",
          value : aws_db_instance.retool_database.address
        },
        {
          name : "POSTGRES_SSL_ENABLED",
          value : "true"
        },
        {
          name : "POSTGRES_PORT",
          value : "5432"
        },
        {
          name : "POSTGRES_USER",
          value : "retool"
        },
        {
          name : "COOKIE_INSECURE",
          value : "false"
        }
      ]
      secrets = [
        {
          name      = "POSTGRES_PASSWORD"
          valueFrom = aws_secretsmanager_secret_version.retool_database_password.arn
        },
        {
          name      = "JWT_SECRET"
          valueFrom = aws_secretsmanager_secret_version.retool_jwt_secret.arn
        },
        {
          name      = "ENCRYPTION_KEY"
          valueFrom = aws_secretsmanager_secret_version.retool_encryption_key.arn
        },
        {
          name      = "LICENSE_KEY"
          valueFrom = aws_secretsmanager_secret_version.retool_license_key.arn
        }
      ]
      portMappings = [
        {
          containerPort = 3000
        }
      ]
      command = ["./docker_scripts/start_api.sh"]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.retool.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "SERVICE_RETOOL"
        }
      }
    }
  ])

}

resource "aws_ecs_task_definition" "retool_jobs_runner" {
  family = "retool-jobs-runner"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  task_role_arn      = aws_iam_role.retool_task.arn
  execution_role_arn = aws_iam_role.retool_execution.arn

  container_definitions = jsonencode([
    {
      name      = "retool-api"
      image     = "${local.retool_image}"
      essential = true
      environment = [
        {
          name : "NODE_ENV",
          value : "production"
        },
        {
          name : "SERVICE_TYPE",
          value : "JOBS_RUNNER"
        },
        {
          name : "FORCE_DEPLOYMENT",
          value : "false"
        },
        {
          name : "POSTGRES_DB",
          value : "hammerhead_production"
        },
        {
          name : "POSTGRES_HOST",
          value : aws_db_instance.retool_database.address
        },
        {
          name : "POSTGRES_SSL_ENABLED",
          value : "true"
        },
        {
          name : "POSTGRES_PORT",
          value : "5432"
        },
        {
          name : "POSTGRES_USER",
          value : "retool"
        }
      ]
      secrets = [
        {
          name      = "POSTGRES_PASSWORD"
          valueFrom = aws_secretsmanager_secret_version.retool_database_password.arn
        },
        {
          name      = "JWT_SECRET"
          valueFrom = aws_secretsmanager_secret_version.retool_jwt_secret.arn
        },
        {
          name      = "ENCRYPTION_KEY"
          valueFrom = aws_secretsmanager_secret_version.retool_encryption_key.arn
        },
        {
          name      = "LICENSE_KEY"
          valueFrom = aws_secretsmanager_secret_version.retool_license_key.arn
        }
      ]
      command = ["./docker_scripts/start_api.sh"]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.retool.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "SERVICE_RETOOL"
        }
      }
    }
  ])

}

// services

resource "aws_ecs_service" "retool_api" {
  name            = "retool-api"
  cluster         = aws_ecs_cluster.retool.id
  task_definition = aws_ecs_task_definition.retool_api.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.retool.arn
    container_name   = "retool-api"
    container_port   = 3000
  }

  network_configuration {
    subnets          = data.aws_subnets.subnets.ids
    security_groups  = [aws_security_group.retool.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_service" "retool_jobs_runner" {
  name            = "retool-jobs-runner"
  cluster         = aws_ecs_cluster.retool.id
  task_definition = aws_ecs_task_definition.retool_jobs_runner.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.subnets.ids
    security_groups  = [aws_security_group.retool.id]
    assign_public_ip = true
  }
}