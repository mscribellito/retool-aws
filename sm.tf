// database password

resource "random_password" "retool_database_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "retool_database_password" {
  name = "retool-database-password"
}

resource "aws_secretsmanager_secret_version" "retool_database_password" {
  secret_id     = aws_secretsmanager_secret.retool_database_password.id
  secret_string = random_password.retool_database_password.result
}

// JWT secret

resource "random_password" "retool_jwt_secret" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "retool_jwt_secret" {
  name = "retool-jwt-secret"
}

resource "aws_secretsmanager_secret_version" "retool_jwt_secret" {
  secret_id     = aws_secretsmanager_secret.retool_jwt_secret.id
  secret_string = random_password.retool_jwt_secret.result
}

// encryption key

resource "random_password" "retool_encryption_key" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "retool_encryption_key" {
  name = "retool-encryption-key"
}

resource "aws_secretsmanager_secret_version" "retool_encryption_key" {
  secret_id     = aws_secretsmanager_secret.retool_encryption_key.id
  secret_string = random_password.retool_encryption_key.result
}

// license key

resource "aws_secretsmanager_secret" "retool_license_key" {
  name = "retool-license-key"
}

resource "aws_secretsmanager_secret_version" "retool_license_key" {
  secret_id     = aws_secretsmanager_secret.retool_license_key.id
  secret_string = var.retool_license_key
}