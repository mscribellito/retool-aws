// security groups

resource "aws_security_group" "ingress" {
  name   = "retool-ingress"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "retool" {
  name   = "retool"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.ingress.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "retool_database" {
  name   = "retool-database"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.retool.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// load balancing

resource "aws_lb" "retool" {
  name               = "retool"
  idle_timeout       = 60
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ingress.id]
  subnets            = data.aws_subnets.subnets.ids
}

resource "aws_lb_listener" "retool" {
  load_balancer_arn = aws_lb.retool.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.retool.arn
  }
}

resource "aws_lb_listener_rule" "retool" {
  listener_arn = aws_lb_listener.retool.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.retool.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_lb_target_group" "retool" {
  name                 = "retool"
  port                 = 3000
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = 30

  health_check {
    healthy_threshold   = 4
    interval            = 61
    path                = "/api/checkHealth"
    protocol            = "HTTP"
    timeout             = 30
    unhealthy_threshold = 10
  }
}