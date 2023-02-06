resource "aws_db_subnet_group" "retool_database" {
  name       = "retool-database"
  subnet_ids = data.aws_subnets.subnets.ids
}

resource "aws_db_instance" "retool_database" {
  identifier             = "retool-database"
  allocated_storage      = 80
  db_name                = "hammerhead_production"
  db_subnet_group_name   = aws_db_subnet_group.retool_database.name
  engine                 = "postgres"
  engine_version         = "11.16"
  instance_class         = "db.t3.micro"
  username               = "retool"
  password               = aws_secretsmanager_secret_version.retool_database_password.secret_string
  vpc_security_group_ids = [aws_security_group.retool_database.id]
  skip_final_snapshot    = true
}