variable "region" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
}

variable "retool_version" {
  type        = string
  description = "Retool version number."
}

variable "retool_license_key" {
  type        = string
  description = "Retool license key."
  default     = "EXPIRED-LICENSE-KEY-TRIAL"
}