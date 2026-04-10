variable "db_username" {
  type        = string
  description = "Primary RDS master username."
  default     = "fincorp_admin"
}

variable "db_password" {
  type        = string
  description = "Primary RDS master password."
  sensitive   = true
}

variable "allowed_cidr" {
  type        = string
  description = "CIDR allowed to connect to Postgres (5432)."
  default     = "0.0.0.0/0"
}
